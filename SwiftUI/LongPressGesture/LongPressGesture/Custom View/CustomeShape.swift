//
//  CustomeShape.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI

struct Tringle : Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }


}

struct Diamond : Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomeShape: View {
    var body: some View {
        ZStack{
            VStack(spacing : 20){
            Tringle()
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [10]))
                .foregroundColor(.blue)
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.red,Color.blue]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 300)
            
            Diamond()
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [10]))
                .foregroundColor(.blue)
                .frame(width: 300, height: 300)
            }
        }
    }
}

struct CustomeShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomeShape()
    }
}
