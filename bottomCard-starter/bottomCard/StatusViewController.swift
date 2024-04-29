//
//  StatusViewController.swift
//  bottomCard
//
//  Created by Soulchild on 30/08/2019.
//  Copyright © 2019 fluffy. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    @IBOutlet weak var reactionListButton: UIButton!
    
    var currentSnapshotImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        addIconToActionButtons()
    }
    
    @IBAction func reactionListButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReactionViewController") as! ReactionViewController
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            vc.backingImage = self.tabBarController?.view.asImage()
        }
//        vc.backingImage = self.tabBarController?.view.asImage()
        present(vc, animated: false)
    }
    
    private func addIconToActionButtons() {
        let labels = [likeLabel, commentLabel, shareLabel]
        let texts = ["Like", "Comment", "Share"]
        // Image assets name used for the icons
        let iconNames = ["Like", "Comment", "Share"]
        
        for (label,(text, iconName)) in zip(labels, zip(texts, iconNames)) {
            let iconAttachment = NSTextAttachment()
            iconAttachment.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
            let iconOffsetY : CGFloat = -2.0;
            iconAttachment.bounds = CGRect(x: -4, y: iconOffsetY, width: 16.0, height: 16.0)
            
            let attachmentString = NSAttributedString(attachment: iconAttachment)
            // iOS bug, must use an empty space string before appending icon attachment
            // else the tint color won't work
            let labelText = NSMutableAttributedString(string: " ")
            labelText.append(attachmentString)
            labelText.append(NSMutableAttributedString(string: text))
            
            label?.textAlignment = .center
            label?.attributedText = labelText
            label?.tintColor = UIColor(named: "ActionButtonGray")
        }
    }
}
