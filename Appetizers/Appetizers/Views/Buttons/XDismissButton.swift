//
//  XDismissButton.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack{
            Circle()
                 .frame(width: 30, height: 30)
                 .foregroundColor(.white)
                 .opacity(0.6)
            Image(systemName: "xmark")
                .frame(width: 44, height: 44)
                .imageScale(.small)
                .foregroundColor(.black)
//                Image(systemName: "xmark")
//                    .frame(width: 30, height: 30)
//                    .background(.white)
//                    .cornerRadius(15)
//                    .foregroundColor(.black)
//                    .imageScale(.small)
//                    .padding(.all,5)
//                    .opacity(0.6)
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}
