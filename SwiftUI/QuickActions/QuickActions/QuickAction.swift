//
//  QuickAction.swift
//  QuickActions
//
//  Created by mac on 23/04/24.
//

import Foundation
import SwiftUI


struct QuickAction : Hashable {
    var type : String
    var title : String
    var subtitle: String
    var icon : String
    
    func quickAction() -> UIApplicationShortcutItem{
        return UIApplicationShortcutItem(type: self.type, localizedTitle: self.title, localizedSubtitle: self.subtitle, icon: .init(systemImageName: self.icon), userInfo: ["type":self.type as NSSecureCoding])
    }
    
}


enum ActionTypes : CaseIterable {
    case DynamicOne
    case DynamicTwo
    case DynamicThree
    case StaticOne
    case StaticTwo
    
    var instance : QuickAction {
        switch self {

        case . DynamicOne: return QuickAction(type: "dynamic1", title: "First Dynamic", subtitle: "This is the first dynamic action", icon: "1.circle")
        case . DynamicTwo: return QuickAction(type: "dynamic2", title: "Second Dynamic", subtitle: "This is the second dynamic action", icon: "2.circle")
        case . DynamicThree: return QuickAction(type: "dynamic3", title: "Third Dynamic", subtitle: "This is the third dynamic action", icon: "3.circle")
        case . StaticOne: return QuickAction(type: "static1", title: "First Action", subtitle: "This is the first static action", icon: "1.circle")
        case . StaticTwo: return QuickAction(type: "static2", title: "Second Action", subtitle: "This is the first static action", icon: "2.square")
            
        }
    }
    
}

let allDynamicActions:[QuickAction] = [
    ActionTypes.DynamicOne.instance,
    ActionTypes.DynamicTwo.instance
]

func getActions(_ typeString : String) -> QuickAction? {
    if let action = ActionTypes.allCases.first(where: {$0.instance.type == typeString}){
        return action.instance
    }
    else{
        return nil
    }
}

class QuickActionObservable : ObservableObject {
    @Published var selectedAction : QuickAction? = nil
}
