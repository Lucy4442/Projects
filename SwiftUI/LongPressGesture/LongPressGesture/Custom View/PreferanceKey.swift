//
//  PreferanceKey.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct PreferanceKey: View {
    
    @State var rectSize : CGSize = .zero
    
    var body: some View {
            VStack{
                Spacer()
                
                Text("Hello, World!")
                    .frame(width : rectSize.width,height: rectSize.height)
                    .background(Color.blue)
                Spacer()
                
                HStack{
                    Rectangle()
                    
                    GeometryReader{geo in
                        Rectangle()
                            .updategeoSize(size: geo.size)
                    }
                    
                    Rectangle()
                }
                .frame(height : 55)
            }
            .onPreferenceChange(GeoPreferanceKey.self) { value in
                self.rectSize = value
            }
       
    }
}

extension View {
    
    func updategeoSize(size : CGSize) -> some View {
        preference(key: GeoPreferanceKey.self, value: size)
    }
}

struct GeoPreferanceKey : PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct PreferanceKey_Previews: PreviewProvider {
    static var previews: some View {
        PreferanceKey()
    }
}
