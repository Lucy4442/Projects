//
//  TabBarPreferanceKey.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import Foundation
import  SwiftUI

struct TabBarItemPreferanceKey : PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}


struct TabBarItemViewModifier : ViewModifier {
    let tab : TabBarItem
    @Binding var selection : TabBarItem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: TabBarItemPreferanceKey.self, value: [tab])
    }
}

extension View {
    
    func tabBarItem(tab : TabBarItem,selection : Binding<TabBarItem>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
