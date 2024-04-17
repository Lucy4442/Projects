////
////  VisualEffect.swift
////  LongPressGesture
////
////  Created by mac on 05/04/24.
////
//
//import SwiftUI
//
//struct VisualEffectView: View {
//    func getPercentage(geo: GeometryProxy) -> Double{
//        let maxDistance = UIScreen.main.bounds.height / 2
//        let currentX = geo.frame(in: .global).midY
//        print(maxDistance," ",currentX)
//        return Double(1 - (currentX / maxDistance))
//    }
//    var body: some View {
//            ScrollView{
//                VStack(spacing:50){
//                ForEach(0..<100){ _ in
//                    Rectangle()
//                        .frame(width: 300,height: 550)
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .frame(maxWidth: .infinity)
////                        .background(.orange)
//                        .visualEffect { content, geometryProxy in
//                            content
//                                .rotation3DEffect(Angle(degrees: getPercentage(geo: geometryProxy) * 55), axis: (x: 1, y: 1, z: 0))
////                                .offset(x: geometryProxy.frame(in: .global).minY * 0.5 )
//
//                        }
//                        .padding()
////                        .background(.orange)
//                }
//            }
//        }
//
//    }
//}
//struct VisualEffect_Previews: PreviewProvider {
//    static var previews: some View {
//        VisualEffectView()
//    }
//}
