//
//  CustomNavBarContainerView.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content : View>: View {
    
    let content : Content
    
    @State var showbackButton : Bool = true
    @State var title : String = ""
    @State var subTitle : String? = nil
    
    init(@ViewBuilder content : () -> Content)
    {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing : 0)
        {
            CustomNavBarView(showbackButton: showbackButton, title: title, subTitle: subTitle)
            content
                .frame(maxWidth : .infinity,maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferanceKey.self) { newValue in
            self.title = newValue
        }
        .onPreferenceChange(CustomNavBarSubTitlePreferanceKey.self) { newValue in
            self.subTitle = newValue
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferanceKey.self) { newValue in
            self.showbackButton = !newValue
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView{
            ZStack{
                Color.green
                    .ignoresSafeArea()
                Text("Hello World!")
                    .foregroundColor(.white)
                    .customNavigationTitle("New Title")
            }
           
        }
    }
}
