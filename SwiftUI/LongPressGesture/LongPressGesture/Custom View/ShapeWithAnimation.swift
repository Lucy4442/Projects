//
//  ShapeWithAnimation.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI


struct RectangleSingleCornerAnimation : Shape {
    
    var cornerRadius : CGFloat
    
    var animatableData: CGFloat {
        get{ cornerRadius }
        
        set{ cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Pacman : Shape {
    
    var offsetAmout : CGFloat
    var animatableData: CGFloat
    {
        get{
            offsetAmout
        }
        set{
            offsetAmout = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.minY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: offsetAmout),
                        endAngle: Angle(degrees: 360 - offsetAmout),
                        clockwise: false)
        }
    }
}

struct ShapeWithAnimation: View {
    
    @State private var animate : Bool = false
    
    var body: some View {
        ZStack{
            Pacman(offsetAmout: animate ? 20 : 0)
                .frame(width: 250, height: 250)
        }
        .onAppear {
            withAnimation(Animation.easeInOut.repeatForever()){
                animate.toggle()
            }
        }
    }
}


struct ShapeWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ShapeWithAnimation()
    }
}
