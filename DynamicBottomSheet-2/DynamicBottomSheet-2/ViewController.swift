//
//  ViewController.swift
//  DynamicBottomSheet-2
//
//  Created by mac on 24/04/24.
//

import UIKit
import LBBottomSheet

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }

    @IBAction func showMe(_ sender: Any) {
        let controller: SecondViewController = .init()
        let grabberBackground: BottomSheetController.Theme.Grabber.Background = .color(.red, isTranslucent: false)
        let grabber: BottomSheetController.Theme.Grabber = .init(background: grabberBackground)
        let theme: BottomSheetController.Theme = .init(grabber: grabber)
        let behavior = BottomSheetController.Behavior(heightMode: .free(minHeight: 300.0, maxHeight: 600.0))
        presentAsBottomSheet(controller, theme: theme, behavior: behavior)
    }
    
}

