//
//  CustomeViewModifier.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI

struct DefaultButtonViewModifer : ViewModifier {
    
    let backGroundColor : Color
    
    func body(content : Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height : 55)
            .frame(maxWidth : .infinity)
            .background(backGroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFormatting(backGroundColor : Color = .green) -> some View {
        modifier(DefaultButtonViewModifer(backGroundColor: backGroundColor))
    }
}

struct CustomeViewModifier: View {
    var body: some View {
        VStack {
            Text("Click Me")
                .font(.headline)
                .withDefaultButtonFormatting(backGroundColor: .blue)
            
            Text("That's Something New")
                .font(.title)
                .modifier(DefaultButtonViewModifer(backGroundColor: .orange))
            
            Text("It's Custom Modifier")
                .font(.title)
                .withDefaultButtonFormatting()
        }
        .padding()

    }
}

struct CustomeViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        CustomeViewModifier()
    }
}
