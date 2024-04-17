//
//  Mask.swift
//  LongPressGesture
//
//  Created by mac on 02/04/24.
//

import SwiftUI

struct Mask: View {
    
    @State var rating : Int = 0
    
    var body: some View {
        ZStack{
            starView
                .overlay(overlayView.mask(starView))
        }
    }
    
    private var starView : some View {
        HStack{
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.linear)
                        {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView : some View {
        GeometryReader{ geometry in
            ZStack(alignment : .leading)
            {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red,Color.blue]), startPoint: .leading, endPoint: .trailing)
                        
                    )
                    .frame(width : CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
        
    }
}

struct Mask_Previews: PreviewProvider {
    static var previews: some View {
        Mask()
    }
}

