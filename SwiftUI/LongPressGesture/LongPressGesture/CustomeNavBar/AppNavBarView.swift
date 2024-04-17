//
//  CustomeNavBar.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        NavigationView{
            CustomNavView{
                ZStack{
                    Color.orange.ignoresSafeArea()
                    
                    CustomNavLink(destination:
                                    Text("Destination")
                                    .customNavigationTitle("Second Screen")
                                    .customNavigationSubTitle("Showing SubTitle")
                    ) {
                        Text("Navigate")
                    }
                }
                .customNavBarItem(title: "New Title", subTitle: nil, backButtonHidden: true)
            }
        }
    }
}

struct CustomeNavBar_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}


extension AppNavBarView {
    
    var defaultView : some View {
        
        ZStack{
            Color.green.ignoresSafeArea()
            NavigationLink {
                Text("Destination")
                    .navigationTitle("Title 2")
                    .navigationBarBackButtonHidden(false)
            } label: {
                Text("Navigate")
            }
            
        }
        .navigationTitle("Nav Title Here")
        
    }
}
