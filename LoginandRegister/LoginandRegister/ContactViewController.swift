//
//  WelcomeViewController.swift
//  LoginAndRegister
//
//  Created by mac on 10/05/24.
//

import UIKit

class ContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        navigateToLoginViewController()
    }
    
    private func navigateToLoginViewController() {
           guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                 let sceneDelegate = windowScene.delegate as? SceneDelegate else {
               return
           }
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           sceneDelegate.window?.rootViewController = loginVC
           sceneDelegate.window?.makeKeyAndVisible()
       }
    
   
}
