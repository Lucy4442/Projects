//
//  CustomShapeWithArcAndCurve.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct ArcSample : Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 40),
                        clockwise: true)
        }
    }
}

struct ShapeWithArc : Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            //top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            //top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            //mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            //bottom
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            //mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            //top left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct WaterShape : Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}

struct CustomShapeWithArcAndCurve: View {
    var body: some View {
        ZStack{
            VStack {
                WaterShape()
    //                .stroke(lineWidth: 5)
                    .fill(LinearGradient(colors: [Color.blue,Color.red], startPoint: .leading, endPoint: .trailing))
    //                .frame(width: 200, height: 200)
    //                .rotationEffect(Angle(degrees: 90))
                ShapeWithArc()
                    .stroke(lineWidth: 5)
                    .fill(LinearGradient(colors: [Color.blue,Color.red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 200, height: 200)
    //                .rotationEffect(Angle(degrees: 90))
                
                ArcSample()
                    .stroke(lineWidth: 5)
                    .fill(LinearGradient(colors: [Color.blue,Color.red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 200, height: 200)
    //                .rotationEffect(Angle(degrees: 90))
            }
        }
    }
}

struct CustomShapeWithArcAndCurve_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapeWithArcAndCurve()
    }
}
