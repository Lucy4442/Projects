//
//  ContentView.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI

struct AppetizerTabView: View {
    
    @EnvironmentObject var order : Order
    
    var body: some View {
        TabView{
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
//                    Image(systemName: "house")
//                    Text("Home")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
//                    Image(systemName: "person")
//                    Text("Account")
                }
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "bag")
//                    Image(systemName: "bag")
//                    Text("Home")
                }
                .badge(order.items.count)
            
                
        }
        .accentColor(.brandPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerTabView()
    }
}
