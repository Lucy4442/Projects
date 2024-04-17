//
//  ScrollViewOffsetPreferanceKey.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct ScrollViewPreferanceKey : PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}

struct ScrollViewOffsetPreferanceKey: View {
    
    @State var title : String = " Nav Title Is Here!!"
    @State var scrollViewOffset : CGFloat = 0
    
    var body: some View {
        ScrollView{
            VStack{
                titleLayer
                    .opacity(Double(scrollViewOffset / 300.0))
                    .background(
                        GeometryReader{ geo in
                            Text("")
                                .preference(key: ScrollViewPreferanceKey.self, value: geo.frame(in: .global).minY)
                        }
                    )
                
                contentLayer
            }
            .frame(maxWidth : .infinity)
            .padding()
        }.overlay(Text("\(scrollViewOffset)"))
        .onPreferenceChange(ScrollViewPreferanceKey.self) { value in
            scrollViewOffset = value
        }
        .overlay(navBarLayer.opacity(scrollViewOffset < 40 ? 1 : 0),alignment: .top)
    }
}

struct ScrollViewOffsetPreferanceKey_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferanceKey()
    }
}

extension ScrollViewOffsetPreferanceKey {
    
    var titleLayer : some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth : .infinity,maxHeight: .infinity,alignment: .leading)
    }
    
    var contentLayer : some View {
        ForEach(0..<30){_ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width : 300,height: 200)
        }
    }
    
    var navBarLayer : some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth : .infinity)
            .frame(height : 55)
            .background(.blue)
        
    }
}
