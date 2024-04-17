//
//  CustomeNavBarView.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct CustomNavBarView: View {
    
    let showbackButton : Bool
    let title : String
    let subTitle : String?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            
            if showbackButton {
                backButton
            }
            
            Spacer()
            titleView
            Spacer()
            if showbackButton {
                backButton
                    .opacity(0)
            }
            

        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(.blue)
    }
}

struct CustomeNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showbackButton: true, title: "Title Here", subTitle: "SubTitle Here!")
            Spacer()
        }
    }
}


extension CustomNavBarView {
    var backButton : some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
}

extension CustomNavBarView {
    var titleView: some View {
        VStack(spacing : 4){
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(subTitle ?? "")
        }
    }
}
