//
//  AccessibilityText.swift
//  LongPressGesture
//
//  Created by mac on 05/04/24.
//

import SwiftUI

struct AccessibilityText: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack{
                            Image(systemName: "heart.fill")
                            Text("Kese he aplog")
                                .truncationMode(.tail)
                        }
                        .font(.title)
                        
                        Text("This is some samle text that expand to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth : .infinity,alignment: .leading)
                            .truncationMode(.head)
                            .lineLimit(3)
                            .minimumScaleFactor(sizeCategory.customMinFactor)
                    }
//                    .frame(height: 100)
                    .background(Color.red)
                    
                }
               
            }
            .listStyle(.plain)
            .navigationTitle("Hello World")
        }
    }
}

extension ContentSizeCategory {
    
    var customMinFactor : CGFloat {
        switch self {
        case .extraSmall,.small,.medium:
            return 1
        case .large,.extraLarge,.extraExtraLarge:
            return 0.8
        default :
            return 0.6
        }
    }
}

struct AccessibilityText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccessibilityText()
                
            
        }
            
            
    }
}
