//
//  CustomTabBarContainerView.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content : View>: View {
    
    @Binding var selection : TabBarItem
    let content : Content
    @State var tabs : [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>,@ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
      
        ZStack(alignment : .bottom){
                content
                .ignoresSafeArea()
                CustomTabBarView(tabs: tabs, selection: $selection)
            }
            .onPreferenceChange(TabBarItemPreferanceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Person", color: .green)
    ]
    
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
