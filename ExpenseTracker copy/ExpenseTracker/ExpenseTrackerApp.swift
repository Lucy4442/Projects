//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by mac on 29/04/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionVM)
        }
    }
}
