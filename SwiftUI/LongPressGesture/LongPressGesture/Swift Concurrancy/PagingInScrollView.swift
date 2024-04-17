////
////  PagingInScrollView.swift
////  LongPressGesture
////
////  Created by mac on 05/04/24.
////
//
//import SwiftUI
//
//struct PagingScrollView: View {
//    var body: some View {
//        ScrollView(.horizontal){
//            HStack(spacing: 0){
//                ForEach(0..<20){ index in
//                Rectangle()
//                        .frame(width: 300,height: 300)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .overlay {
//                            Text("\(index)").foregroundStyle(.white)
//                        }
//                        .frame(maxWidth:.infinity)
//                        .padding()
//                        .scrollTransition { ContentMode, phase in
//                            ContentMode.opacity(phase.isIdentity ? 1 : 0)
//                                .offset(y:phase.isIdentity ? 0 : -100)
//                        }
////                        .background(.orange)
////                        .containerRelativeFrame(.horizontal)
//
//                }
//            }
//            .padding(.vertical, 100)
//
//        }
//        .scrollTargetLayout()
//        .scrollTargetBehavior(.viewAligned)
//        .scrollBounceBehavior(.basedOnSize)
//    }
//}
//
//struct PagingInScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        PagingScrollView()
//    }
//}
