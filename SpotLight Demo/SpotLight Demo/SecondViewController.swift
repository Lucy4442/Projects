//
//  SecondViewController.swift
//  SpotLight Demo
//
//  Created by mac on 27/03/24.
//

import UIKit
import LRSpotlight

class SecondViewController: UIViewController{

    lazy var wrapper : Wrapper = Wrapper(with: self)
    let spotlight = Spotlight()
    @IBOutlet var bedroom: UIButton!
    @IBOutlet var kitchen: UIButton!
    @IBOutlet var bathroom: UIButton!
    @IBOutlet var livingroom: UIButton!
    
    let child = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    
    weak var thirdViewControllerDelegate: ThirdViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        Spotlight.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wrapper.startTutorial()
    }
}


extension SecondViewController : SpotlightDelegate {
    func didAdvance(to node: Int, of total: Int) {
        print("\(total)")
//        if node == 1 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else {
//                    print("Failed to instantiate ThirdViewController from storyboard")
//                    return
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//
////                 Access thirdView safely
//                if let thirdView = vc.thirdView {
//                    let newnode = SpotlightNode(text: "Next Page", target: .view(thirdView), roundedCorners: true)
//                    self.wrapper.nodes.insert(newnode, at: node)
//                } else {
//                    print("thirdView is nil")
//                }
//            }
//
//        }
    }

    func didDismiss() {
        print("End of Intro")
    }
}
