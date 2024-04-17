//
//  UIViewControllerRepresent.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI

struct UIViewControllerRepresent: View {
    
    @State var showScreen : Bool = false
    @State var image : UIImage? = nil
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width : 200 ,height : 200)
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("CLICK HERE")
            }
            .sheet(isPresented: $showScreen) {
                UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
            }

        }
    }
}

struct UIViewControllerRepresent_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresent()
    }
}


struct BasicUIViewControllerRepresentable : UIViewControllerRepresentable {
    
    let labelText :String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let vc = myViewController()
        vc.labelText = labelText
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

class myViewController : UIViewController {
    var labelText : String = "Starting Value"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        view.addSubview(label)
        label.frame = view.frame
    }
}

struct UIImagePickerControllerRepresentable : UIViewControllerRepresentable {
    
    @Binding var image : UIImage?
    @Binding var showScreen : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image : UIImage?
        @Binding var showScreen : Bool
        init(image : Binding<UIImage?>,showScreen : Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newimage = info[.originalImage] as? UIImage else {
                return
            }
            image = newimage
            showScreen.toggle()
        }
    }
}
