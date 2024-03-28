//
//  SpotLightWrapper.swift
//  SpotLight Demo
//
//  Created by mac on 27/03/24.
//

import Foundation
import SwiftUI
import LRSpotlight


final class SpotlightWrapper{

    var viewController : UIViewController?
    
    init(with viewController : UIViewController)
    {
        self.viewController = viewController
    }
    
    func startTutorial(){
        guard let viewController = viewController as? ViewController else {
            return
        }
        
        guard let LBB = viewController.navigationItem.leftBarButtonItem,
              let RBB = viewController.navigationItem.rightBarButtonItem,
              let navBar = viewController.navigationController?.navigationBar else { return }

        
        let node1 = SpotlightNode(text: "Just getting started with walkthrough" , target: .point(CGPoint(x: -50, y: -50), radius: 40))
        let node2 = SpotlightNode(text: "Click to open menu", target: .barButton(LBB), roundedCorners: true)
        let node3 = SpotlightNode(text: "Click to edit Profile", target: .barButton(RBB), roundedCorners: true)
        let node4 = SpotlightNode(text: "Move using point and radius", target: .point(CGPoint(x: viewController.view.frame.width / 2, y: navBar.frame.midY + navBar.frame.height), radius: 20))
        let node5 = SpotlightNode(text: "That is verticalView with blue color", target: .view(viewController.verticalView))
        let node6 = SpotlightNode(text: "That is label view ", target: .view(viewController.Spotlightlabel))
        
        let nodes = [node1,node2,node3,node4,node5,node6]
        
        Spotlight.delay = 5
        Spotlight.backgroundColor = .lightGray
        let spotlight = Spotlight()
        spotlight.delegate = self
//        spotlight.startIntro(from: viewController, withNodes: nodes)
        
    }
}

extension SpotlightWrapper : SpotlightDelegate {
    func didAdvance(to node: Int, of total: Int) {
        print("Showing \(node) of \(total)")
    }
    
    func didDismiss() {
        print("End of Intro")
    }
    
    
}
