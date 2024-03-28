//
//  SecondViewController.swift
//  SpotLight Demo
//
//  Created by mac on 27/03/24.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var wrapper : Wrapper = Wrapper(with: self)
    @IBOutlet var bedroom: UIButton!
    @IBOutlet var kitchen: UIButton!
    @IBOutlet var bathroom: UIButton!
    @IBOutlet var livingroom: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wrapper.startTutorial()
    }
}
