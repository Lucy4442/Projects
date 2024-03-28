//
//  ViewController.swift
//  SpotLight Demo
//
//  Created by mac on 27/03/24.
//

import UIKit
import LRSpotlight

class ViewController: UIViewController {

    private lazy var wrapper : SpotlightWrapper = SpotlightWrapper(with: self)
    @IBOutlet var verticalView: UIView!
    @IBOutlet var Spotlightlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(cgColor: UIColor.white.cgColor)]
        wrapper.startTutorial()
    }


}

