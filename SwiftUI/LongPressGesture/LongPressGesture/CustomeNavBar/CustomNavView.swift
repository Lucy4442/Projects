//
//  CustomNavView.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI

struct CustomNavView<Content : View>: View {
    
    let content : Content
    
    init(@ViewBuilder content : () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView{
            CustomNavBarContainerView{
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView{
            Color.red.ignoresSafeArea()
        }
    }
}


extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
