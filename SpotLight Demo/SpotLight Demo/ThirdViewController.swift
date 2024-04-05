//
//  ThirdViewController.swift
//  SpotLight Demo
//
//  Created by mac on 01/04/24.
//

import UIKit
import LRSpotlight

protocol ThirdViewControllerDelegate: AnyObject {
    var passView: UIView { get }
}


class ThirdViewController: UIViewController, ThirdViewControllerDelegate {
    lazy var wrapper : Wrapper = Wrapper(with: self)
    var passView: UIView { return view }
    @IBOutlet var thirdView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        Spotlight.delegate = self
    }

}

//extension ThirdViewController : SpotlightDelegate {
//    func didAdvance(to node: Int, of total: Int) {
//            let newnode = SpotlightNode(text: "Next Page", target: .view(self.thirdView), roundedCorners: true)
//            self.wrapper.nodes.insert(newnode, at: node)
//    }
//
//    func didDismiss() {
//        print("")
//    }
//
//
//
//}
