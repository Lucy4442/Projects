//
//  LoginViewController.swift
//  LoginAndRegister
//
//  Created by mac on 10/05/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ViewController.hasOpenedBefore {
            navigateToWelcomeViewController()
        }
    }
    
    private func loginUser(user : String,password : String){
        
        
    }
    
    @IBAction func loginBtnTapped(_sender : Any){
        
    }
    
    @IBAction func registerBtnTapped(_sender : Any){
        
    }
    
    private func navigateToWelcomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        self.navigationController?.setViewControllers([tabbarVC], animated: true)
    }
}
