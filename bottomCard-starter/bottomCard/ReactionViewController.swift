//
//  ReactionViewController.swift
//  bottomCard
//
//  Created by mac on 24/04/24.
//  Copyright © 2024 fluffy. All rights reserved.
//

import UIKit

class ReactionViewController: UIViewController {

    @IBOutlet var backingImageView: UIImageView!
    @IBOutlet var dimmedView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var handleView: UIView!
    
    enum CardViewState {
        case expanded
        case normal
    }
    
    var cardViewState : CardViewState = .normal
    var cardpanStartingTopConstant : CGFloat = 30.0
    
    var backingImage : UIImage?{
        didSet{
            backingImageView.image = backingImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add TapGesture to dimmedView
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmerTap)
        
        //add pan Gesture to root View
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.view.addGestureRecognizer(viewPan)
        
        backingImageView.image = backingImage
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom{
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        dimmedView.alpha = 0.0
        
        
        handleView.clipsToBounds = true
        handleView.layer.cornerRadius = 3.0
    }
    
    @IBAction func dimmedViewTapped(_ tapRecognizer : UITapGestureRecognizer)
    {
        hideCardAndGoBack()
    }
    
    @IBAction func viewPanned(_ panRecognizer : UIPanGestureRecognizer)
    {
        let translation = panRecognizer.translation(in: self.view)
        
        let velocity = panRecognizer.velocity(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            cardpanStartingTopConstant = cardViewTopConstraint.constant
        case .changed:
            if self.cardpanStartingTopConstant + translation.y > 30.0 {
                self.cardViewTopConstraint.constant = self.cardpanStartingTopConstant + translation.y
            }
            dimmedView.alpha = dimAlphaWithCardTopConstraint(value: self.cardViewTopConstraint.constant)
        case .ended:
            print("hello")
//
//            if velocity.y > 1500 {
//                hideCardAndGoBack()
//                return
//            }
//
//            if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom{
//                if(self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.25){
//                    showCard(atState: .expanded)
//                }
//                else if (self.cardViewTopConstraint.constant < (safeAreaHeight) - 70) {
//                    showCard(atState: .normal)
//                }else{
//                    hideCardAndGoBack()
//                }
//            }
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showCard()
    }

    func showCard(atState : CardViewState = .normal){
        self.view.layoutIfNeeded()
        
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom{
            
            if atState == .expanded{
                cardViewTopConstraint.constant = 30
            }else{
                cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.0
            }
            cardpanStartingTopConstant = cardViewTopConstraint.constant
        }
        
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }
        
        showCard.addAnimations {
            self.dimmedView.alpha = 0.7
        }
        showCard.startAnimation()
    }
    
    func hideCardAndGoBack(){
        self.view.layoutIfNeeded()
        
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom{
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }
        
        hideCard.addAnimations {
            self.dimmedView.alpha = 0
        }
        
        hideCard.addCompletion { position in
            if position == .end {
                if(self.presentingViewController != nil)
                {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        
        hideCard.startAnimation()
    }
    
    private func dimAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
      let fullDimAlpha : CGFloat = 0.7
      
      // ensure safe area height and safe area bottom padding is not nil
      guard let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
        let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
        return fullDimAlpha
      }
      
      // when card view top constraint value is equal to this,
      // the dimmer view alpha is dimmest (0.7)
      let fullDimPosition = (safeAreaHeight + bottomPadding) / 2.0
      
      // when card view top constraint value is equal to this,
      // the dimmer view alpha is lightest (0.0)
      let noDimPosition = safeAreaHeight + bottomPadding
      
      // if card view top constraint is lesser than fullDimPosition
      // it is dimmest
      if value < fullDimPosition {
        return fullDimAlpha
      }
      
      // if card view top constraint is more than noDimPosition
      // it is dimmest
      if value > noDimPosition {
        return 0.0
      }
      
      // else return an alpha value in between 0.0 and 0.7 based on the top constraint value
      return fullDimAlpha * 1 - ((value - fullDimPosition) / fullDimPosition)
    }
}
