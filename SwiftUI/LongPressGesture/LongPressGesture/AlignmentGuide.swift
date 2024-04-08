//
//  AlignmentGuide.swift
//  LongPressGesture
//
//  Created by mac on 05/04/24.
//

import SwiftUI

struct AlignmentGuide: View {
    var body: some View {
        VStack(alignment : .leading) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.blue)

            
            Text("This is some text!!!")
                .background(.red)
        }
        .background(.orange)
        
        
    }
}

struct AlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuide()
    }
}
