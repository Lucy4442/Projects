//
//  CustomNavLink.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI


struct CustomNavLink<Label : View,Destination : View>: View {
    
    let destination : Destination
    let label : Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label){
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView
            {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }

    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView{
            CustomNavLink(destination: Text("Destination")){
                Text("CLICK ME")
            }
        }
    }
}
