//
//  AFButton.swift
//  Apple-Frameworks
//
//  Created by mac on 14/03/24.
//

import SwiftUI

struct AFButton: View {
    
    var title : String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 280, height: 50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct AFButton_Previews: PreviewProvider {
    static var previews: some View {
        AFButton(title: "Test title")
    }
}
