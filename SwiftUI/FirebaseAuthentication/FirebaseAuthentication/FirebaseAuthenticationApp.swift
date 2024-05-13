//
//  FirebaseAuthenticationApp.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import SwiftUI
import Firebase

@main
struct FirebaseAuthenticationApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView{
                RootView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configure Completed")
    return true
  }
}
