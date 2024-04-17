//
//  ShimmerEffect.swift
//  LongPressGesture
//
//  Created by mac on 17/04/24.
//

import SwiftUI

struct ShimmerEffect: View {
    
    var gradientColors = [Color.gray,Color.clear,Color.gray]
    @State var isAnimating = false
    @State var startpoint : UnitPoint = .init(x: -1, y: 0.5)
    @State var endpoint : UnitPoint = .init(x: 0, y: 0.5)
    
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: startpoint, endPoint: endpoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false))
                {
                    startpoint = .init(x: 1.5, y: 0.5)
                    endpoint = .init(x: 2, y: 0.5)
                }
            }
    }
}

struct ShimmerEffect_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerEffect()
    }
}
