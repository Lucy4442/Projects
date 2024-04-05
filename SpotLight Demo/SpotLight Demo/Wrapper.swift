//
//  SpotLightWrapper.swift
//  SpotLight Demo
//
//  Created by mac on 27/03/24.
//

import Foundation
import SwiftUI
import LRSpotlight


 class Wrapper{

    var viewController : UIViewController?
     var nodes : [SpotlightNode] = []
    init(with viewController : UIViewController)
    {
        self.viewController = viewController
    }
    
    func startTutorial(){
        guard let viewController = viewController as? SecondViewController else {
            return
        }
        
        guard let tabBarController = viewController.tabBarController else {
            return
        }
//        guard let LBB = viewController.navigationItem.leftBarButtonItem,
//              let RBB = viewController.navigationItem.rightBarButtonItem,
//              let navBar = viewController.navigationController?.navigationBar else { return }
        
//        let node1 = SpotlightNode(text: "Just getting started with walkthrough" , target: .point(CGPoint(x: -50, y: -50), radius: 40))
        let node2 = SpotlightNode(text: "Click to navigate to home view", target: .tabBarItem(tabBarController, 0), roundedCorners: true)
        let node3 = SpotlightNode(text: "Here you can see bedroom related service", target: .view(viewController.bedroom))
        let node4 = SpotlightNode(text: "Here you can see kitchen related service", target: .view(viewController.kitchen))
        let node5 = SpotlightNode(text: "Here you can see bathroom related service", target: .view(viewController.bathroom))
        let node6 = SpotlightNode(text: "Here you can see livingroom related service", target: .view(viewController.livingroom))
        let node7 = SpotlightNode(text: "Click to show room related service", target: .tabBarItem(tabBarController, 1), roundedCorners: true)
        let node8 = SpotlightNode(text: "Edit profile", target: .tabBarItem(tabBarController, 2),roundedCorners: true)
        let node9 = SpotlightNode(text: "Click to show show recent service", target: .tabBarItem(tabBarController, 3), roundedCorners: true)

        nodes = [node2,node3,node4,node5,node6,node7,node8,node9]
        
        Spotlight.delay = 5
//        Spotlight.backgroundColor = .white
        let spotlight = Spotlight()
//        spotlight.delegate = self
        spotlight.startIntro(from: viewController, withNodes: nodes)
        
    }
    

}

//extension Wrapper : SpotlightDelegate {
//    func didAdvance(to node: Int, of total: Int) {
//        print("\(total)")
//        if node == 2 {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
//            let newnode = SpotlightNode(text: "Next Page", target: .view(vc.thirdView), roundedCorners: true)
//            nodes.insert(newnode, at: node)
//            
////            let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
////            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//    
//    func didDismiss() {
//        print("End of Intro")
//    }
//    
//    
//}
