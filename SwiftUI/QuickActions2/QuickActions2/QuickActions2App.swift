

import SwiftUI

@main
struct QuickActions2App: App {
    @StateObject var vm = ViewModel()
    @Environment(\.scenePhase) var phase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onChange(of: phase) { newValue in
                    switch newValue{
                    case .active:
                        if let name = QuickAction.selectedAction?.userInfo?["name"] as? String {
                            vm.selectFilter(for: name)
                        }
                        else{
                            vm.selectedClassification = .all
                            vm.loadItems()
                        }
                    case .background:
                        vm.addQuickActions()
                    default:
                        break
                    }
                }
        }
    }
}
