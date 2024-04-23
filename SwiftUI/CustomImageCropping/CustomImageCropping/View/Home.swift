//
//  Home.swift
//  CustomImageCropping
//
//  Created by mac on 23/04/24.
//

import SwiftUI

struct Home: View {
    
    @State private var showPicker : Bool = false
    @State private var croppedImage : UIImage?
    
    var body: some View {
        NavigationView{
            VStack{
                if let croppedImage = croppedImage {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                }else{
                    Text("No Image is Selected")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Crop Image Picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showPicker.toggle()
                    }label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    }
                    .tint(.black)
                }
            }
            .cropimagePicker(options: [.circle,.square,.rectangle], show: $showPicker, croppedImage: $croppedImage)
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
