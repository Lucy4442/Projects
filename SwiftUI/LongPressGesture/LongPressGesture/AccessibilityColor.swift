//
//  AccessibilityColor.swift
//  LongPressGesture
//
//  Created by mac on 05/04/24.
//

import SwiftUI

struct AccessibilityColor: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        VStack(spacing : 10){
            Button("Button 1")
            {
                
            }
            .foregroundColor( colorSchemeContrast == .increased ? .white : .primary)
            .buttonStyle(.borderedProminent)
            
            Button("Button 2")
            {
                
            }
            .foregroundColor(.primary)
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            Button("Button 3")
            {
                
            }
            .foregroundColor(.white)
            .foregroundColor(.primary)
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Button("Button 4")
            {
                
            }
            .foregroundColor( differentiateWithoutColor ? .white : .green)
            .foregroundColor(.primary)
            .buttonStyle(.borderedProminent)
            .tint( differentiateWithoutColor ? .black : .orange)
        }
        .font(.largeTitle)
        .frame(maxWidth : .infinity,maxHeight: .infinity)
        .ignoresSafeArea()
//        .background(reduceTransparency ? Color.black : Color.black.opacity(0.6))
    }
}

struct AccessibilityColor_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityColor()
    }
}
