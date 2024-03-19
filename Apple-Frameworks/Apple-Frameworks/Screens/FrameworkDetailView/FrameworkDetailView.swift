//
//  FrameworkDetailView.swift
//  Apple-Frameworks
//
//  Created by mac on 14/03/24.
//

import SwiftUI

struct FrameworkDetailView: View {
    var framework : Framework
    
    @Binding var isShowingFramework : Bool
    @State private var isShowingSafariView : Bool = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    isShowingFramework = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.label))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                }
                .padding()
            }
            
            Spacer()
            
            FrameworkTitleView(framework: framework)
            
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Button{
                isShowingSafariView = true
            }label: {
               AFButton(title: "Learn More")
            }
        }
        .fullScreenCover(isPresented: $isShowingSafariView) {
            SafariView(url: URL(string: framework.urlString)!)
        }
    }
}

struct FrameworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDetailView(framework: MockData.frameworks[0], isShowingFramework: .constant(false))
            .preferredColorScheme(.dark)
            
    }
}
