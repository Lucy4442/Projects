//
//  CustomImagePicker.swift
//  CustomImageCropping
//
//  Created by mac on 23/04/24.
//

import SwiftUI
import PhotosUI


extension View {
    @ViewBuilder
    func cropimagePicker(options: [Crop],show: Binding<Bool>,croppedImage : Binding<UIImage?>) -> some View {
        CustomImagePicker(options: options, show: show, croppedImage: croppedImage) {
            self
        }
    }
    
    @ViewBuilder
    func frame(_ size : CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}

struct CustomImagePicker<Content : View> : View{
    var content : Content
    var options : [Crop]
    @Binding var show : Bool
    @Binding var croppedImage : UIImage?
    init(options: [Crop],show : Binding<Bool>,croppedImage : Binding<UIImage?>,@ViewBuilder content : @escaping ()->Content) {
        self.content = content()
        self.options = options
        self._croppedImage = croppedImage
        self._show = show
    }
    @State private var photosItem : PhotosPickerItem?
    @State private var selectedImage : UIImage?
    @State private var showDialog : Bool = false
    @State private var selectedCropType: Crop = .circle
    @State private var showCropView : Bool = false
    var body: some View {
        content
            .photosPicker(isPresented: $show, selection: $photosItem)
            .onChange(of: photosItem) { newValue in
                if let newValue {
                    Task{
                        if let imageData = try? await newValue.loadTransferable(type: Data.self),let image = UIImage(data: imageData){
                            await MainActor.run(body: {
                                selectedImage = image
                                showDialog.toggle()
                            })
                        }
                    }
                }
            }
            .confirmationDialog("", isPresented: $showDialog) {
                ForEach(options.indices,id: \.self) { index in
                    Button(options[index].name()){
                        selectedCropType = options[index]
                        showCropView.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $showCropView) {
                selectedImage = nil
            } content: {
                CropView(crop: selectedCropType,image: selectedImage) { croppedImage, status in
                    if let croppedImage {
                        self.croppedImage = croppedImage
                    }
                }
            }
    }
}

struct CropView : View {
    
    var crop : Crop
    var image : UIImage?
    var onCrop : (UIImage?,Bool) -> ()
    @Environment(\.dismiss) var dismiss
    @State private var scale : CGFloat = 1
    @State private var lastScale : CGFloat = 0
    @State private var offset : CGSize = .zero
    @State private var lastStoredOffset : CGSize = .zero
    @GestureState var isInteracting : Bool = false
    var body: some View{
        NavigationStack{
            ImageView()
                .navigationTitle("Crop View")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.black, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content:{
                        Button{
                            let renderer = ImageRenderer(content: ImageView(true))
                            renderer.proposedSize = .init(crop.size())
                            if let image = renderer.uiImage {
                                onCrop(image,true)
                            }else{
                                onCrop(nil,false)
                            }
                            dismiss()
                        }label: {
                            Image(systemName: "checkmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    })
                    
                    ToolbarItem(placement: .navigationBarLeading, content:{
                        Button{
                            dismiss.callAsFunction()
                        }label: {
                            Image(systemName: "xmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    })
                })
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func ImageView(_ hidegrids : Bool = false) -> some View {
        let cropSize = crop.size()
        GeometryReader{
            let size = $0.size
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        GeometryReader(content: { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            
                            Color.clear
                                .onChange(of: isInteracting) { newValue in
                                    withAnimation(.easeInOut(duration: 0.2)){
                                        if rect.minX > 0 {
                                            offset.width = (offset.width - rect.minX)
                                        }
                                        if rect.minY > 0 {
                                            offset.height = (offset.height - rect.minY)
                                        }
                                        if rect.maxX < size.width {
                                            offset.width = (rect.minX - offset.width)
                                        }
                                        if rect.maxY < size.height {
                                            offset.height = (rect.minY - offset.height)
                                        }
                                        
                                    }
                                    
                                    if !newValue {
                                        lastStoredOffset = offset
                                    }
                                }
                        })
                    )
                    .frame(size)
                    
            }
            
        }
        .offset(offset)
        .scaleEffect(scale)
        .overlay(content : {
            if !hidegrids{
                Grids()
            }
        })
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
        DragGesture()
            .updating($isInteracting, body: { _, out, _ in
                out = true
            })
            .onChanged({ value in
                let translation = value.translation
                offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
            })
            .onEnded({ value in
                withAnimation(.easeInOut(duration: 0.2)){
                    if scale < 1 {
                        scale = 1
                        lastScale = 0
                    }else{
                        lastScale = scale - 1
                    }
                        
                }
            })
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let updatedScale = value + lastScale
                    scale = (updatedScale < 1 ? 1 : updatedScale)
                })
        )
        .frame(cropSize)
        .cornerRadius(crop == .circle ? cropSize.height / 2 : 0)
    }
    
    @ViewBuilder
    func Grids() -> some View {
        ZStack{
            HStack{
                ForEach(1...5,id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                }
            }
            VStack{
                ForEach(1...8,id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

struct CustomImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        CropView(crop: .circle,image: UIImage(named : "sample1")){_,_ in
            
        }
    }
}
