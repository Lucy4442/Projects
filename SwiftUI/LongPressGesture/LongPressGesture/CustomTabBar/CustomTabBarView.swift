//
//  CustomTabBarView.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs : [TabBarItem]
    @Binding var selection : TabBarItem
    @Namespace var namespace
    var body: some View {
        HStack{
            ForEach(tabs, id: \.self) {tab in
                    tabView(tab: tab)
                    .onTapGesture {
                        swithTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea())
        .cornerRadius(10)
        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Person", color: .green)
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
        }
//        .padding()
        
    }
}

extension CustomTabBarView {
    func tabView(tab : TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth : .infinity)
        .background(
            ZStack{
                if selection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background", in: namespace)
                }
            }
        )
    }
    
    func swithTab(tab : TabBarItem) {
        withAnimation(.easeInOut){
            selection = tab
        }
    }
}

struct TabBarItem : Hashable {
    let iconName : String
    let title : String
    let color : Color
}

