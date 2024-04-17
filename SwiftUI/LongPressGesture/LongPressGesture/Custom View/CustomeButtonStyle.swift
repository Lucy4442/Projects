//
//  ButtonStyle.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI

struct PressableStyle: ButtonStyle {
    
    let scaleAmount : CGFloat
    
    init(scaleAmount : CGFloat) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? scaleAmount : 1)
    }
}

extension View {
    func withPressableStyle(scaleAmount : CGFloat = 0.9) -> some View {
        buttonStyle(PressableStyle(scaleAmount: scaleAmount))
    }
}

struct CustomeButtonStyle: View {
    var body: some View {
        VStack(spacing : 40) {
            Button {
                
            } label: {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height : 55)
                    .frame(maxWidth : .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .buttonStyle(PressableStyle(scaleAmount: 0.8))
            
            Button {
                
            } label: {
                Text("Custom Modifier")
                    .withDefaultButtonFormatting()
            }
            .withPressableStyle(scaleAmount: 0.5)
        }
        .padding(40)

    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomeButtonStyle()
    }
}
