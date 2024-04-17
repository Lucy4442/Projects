//
//  AppTabBarView.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

//Generics
//ViewBuilder
//PreferanceKey
//MatchedGeometryEffect



struct AppTabBarView: View {
    
    @State var selection : String = "Home"
    @State var tabSelection : TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
                Color.blue
                .tabBarItem(tab: TabBarItem(iconName: "house", title: "Home", color: .red), selection: $tabSelection)
                
                Color.red
                .tabBarItem(tab: TabBarItem(iconName: "heart", title: "Favorites", color: .blue), selection: $tabSelection )
                
                Color.green
                .tabBarItem(tab: TabBarItem(iconName: "person", title: "Person", color: .green), selection: $tabSelection)
        }
        
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Person", color: .green)
    ]
    
    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    
    var defaultTabView : some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.green
                .tabItem {
                    Image(systemName: "heart")
                    Text("Heart")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Person")
                }
        }
        .background()
    }
}
