//
//  EmptyState.swift
//  Appetizers
//
//  Created by mac on 19/03/24.
//

import SwiftUI

struct EmptyState: View {
    
    let imageName : String
    let message : String
    
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y : -50)
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState(imageName: "empty-order", message: "Default Message")
    }
}
