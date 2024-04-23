//
//  QuickActionsApp.swift
//  QuickActions
//
//  Created by mac on 23/04/24.
//

import SwiftUI

@main
struct QuickActionsApp: App {
    @Environment(\.scenePhase) var phase
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: phase) { newValue in
                    switch newValue{
                    case .inactive:
                        print("I")
                    case .active:
                        print("A")
                    case .background:
                        print("B")
                        setupQuickAction()
                    @unknown default : print("D")
                    }
                }
        }
    }
    
    func setupQuickAction(){
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(type: "Edit", localizedTitle: "Edit 1", localizedSubtitle: "Sunheading", icon: UIApplicationShortcutIcon(type: .bookmark), userInfo: ["Edit":"Edit 1" as NSSecureCoding]),
            UIApplicationShortcutItem(type: "Edit", localizedTitle: "Edit 2", localizedSubtitle: "Sunheading", icon: UIApplicationShortcutIcon(type: .bookmark), userInfo: ["Edit":"Edit 2" as NSSecureCoding]),
            UIApplicationShortcutItem(type: "Edit", localizedTitle: "Edit 3", localizedSubtitle: "Sunheading", icon: UIApplicationShortcutIcon(type: .bookmark), userInfo: ["Edit":"Edit 3" as NSSecureCoding]),
            UIApplicationShortcutItem(type: "Edit", localizedTitle: "Edit 4", localizedSubtitle: "Sunheading", icon: UIApplicationShortcutIcon(type: .bookmark), userInfo: ["Edit":"Edit 4" as NSSecureCoding]),
        
        ]
    }
}

class AppDelegate : NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: "Custom Config", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = CustomSceneDelegate.self
        return sceneConfig
    }
}

class CustomSceneDelegate : UIResponder,UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.userInfo as Any)
    }
}
