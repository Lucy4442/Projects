//
//  ViewController.swift
//  LoginAndRegister
//
//  Created by mac on 10/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    static var hasOpenedBefore: Bool {
           return UserDefaults.standard.bool(forKey: "hasOpenedBefore")
       }
    
    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func navigateToViewController(withIdentifier identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
    
     func navigateToWelcomeViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tababrVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            self.navigationController?.setViewControllers([tababrVC], animated: true)
        }
    
    private func registerUser(user: String, password: String) {
        if user.isEmpty {
            showAlert(message: "Username field is empty.")
        } else if password.isEmpty {
            showAlert(message: "Password field is empty.")
        } else {
            // Store username and password to UserDefaults
            UserDefaults.standard.set(user, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set(true, forKey: "hasOpenedBefore")
        }
    }

    @IBAction func registerBtnTapped(_ sender: Any) {
        let user = userTF.text ?? ""
        let password = passwordTF.text ?? ""
        registerUser(user: user, password: password)
        navigateToWelcomeViewController()
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

