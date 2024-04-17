//
//  CustomNavBarPreferanceKeys.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import Foundation
import SwiftUI


//@State var showbackButton : Bool = true
//@State var title : String = "Title"
//@State var subTitle : String? = "Subtitle"

struct CustomNavBarTitlePreferanceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubTitlePreferanceKey: PreferenceKey {
    
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferanceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


extension View {
    
//    .navigationTitle("Title 2")
//    .navigationBarBackButtonHidden(false)
    
    func customNavigationTitle(_ title : String) -> some View {
        self
            .preference(key: CustomNavBarTitlePreferanceKey.self, value: title)
    }
    
    func customNavigationSubTitle(_ subTitle : String?) -> some View {
        self
            .preference(key: CustomNavBarSubTitlePreferanceKey.self, value: subTitle)
    }
    
    func customNavigationBarBackButtonHidden(_ hidden : Bool) -> some View {
        self
            .preference(key: CustomNavBarBackButtonHiddenPreferanceKey.self, value: hidden)
    }
    
    func customNavBarItem(title : String = "",subTitle : String? = nil,backButtonHidden : Bool = false) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubTitle(subTitle)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
}
