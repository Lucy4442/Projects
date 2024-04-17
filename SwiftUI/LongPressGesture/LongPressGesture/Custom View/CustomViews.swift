//
//  CustomeViews.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI

enum AllCases : String, CaseIterable {
    case CustomViewModifier = "CustomViewModifier"
    case CustomButtonStyle = "CustomButtonStyle"
    case CustomTransition = "CustomTransition"
    case CustomShape = "CustomShape"
    case CustomeShapeWithArcAndCurve = "CustomShapeWithArcAndCurve"
    case shapeWithAnimation = "ShapeWithAnimation"
    case scrollViewOffsetPreferanceKey = "ScrollViewOffsetPreferanceKey"
    case CustomTabView = "AppTabBarView"
    case uiViewRepresent = "UIViewRepresent"
    case uiViewControllerRepresent = "UIViewControllerRepresent"
    case TimelineView = "TimeLineView"
//    case customeNavBar = "CustomNavBar"
    var destinationView : AnyView {
        switch self {
        case .CustomViewModifier:
            return AnyView(CustomeViewModifier())
        case .CustomButtonStyle:
            return AnyView(CustomeButtonStyle())
        case .CustomTransition:
            return AnyView(CustomeTransition())
        case .CustomShape:
            return AnyView(CustomeShape())
        case .CustomeShapeWithArcAndCurve:
            return AnyView(CustomShapeWithArcAndCurve())
        case .shapeWithAnimation:
            return AnyView(ShapeWithAnimation())
        case .scrollViewOffsetPreferanceKey:
            return AnyView(ScrollViewOffsetPreferanceKey())
        case .CustomTabView:
            return AnyView(AppTabBarView())
        case .uiViewRepresent:
            return AnyView(UIViewRepresent())
        case .uiViewControllerRepresent:
            return AnyView(UIViewControllerRepresent())
        case .TimelineView:
            return AnyView(TimeLineView())
//        case .customeNavBar:
//            return AnyView(AppNavBarView())
        }
    }
}

struct CustomViews: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(AllCases.allCases, id: \.self) { customView in
                    NavigationLink(destination: customView.destinationView) {
                        Text(customView.rawValue)
                    }
                }
            }
            .navigationTitle("Custom Views")
        }
    }
}

struct CustomeViews_Previews: PreviewProvider {
    static var previews: some View {
        CustomViews()
    }
}
