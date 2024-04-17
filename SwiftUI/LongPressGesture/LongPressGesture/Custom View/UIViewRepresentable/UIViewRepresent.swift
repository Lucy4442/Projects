//
//  UIViewRepresent.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI

struct UIViewRepresent: View {
    
    @State private var text : String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            HStack {
                Text("SwiftUI :")
                TextField("Type Here...", text: $text)
                    .frame(height : 55)
                .background(Color.gray)
            }
            
            HStack{
                Text("UIKit :")
                UITextFieldRepresentable(text: $text,placeholderColor: .blue)
                    .updatePlaceHolder("New Placeholder")
                    .frame(height : 55)
                    .background(Color.gray)
                
            }
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
}

struct UIViewRepresent_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresent()
    }
}

struct UITextFieldRepresentable : UIViewRepresentable {
    
    @Binding var text : String
    var placeholder : String
    let placeHolderColor : UIColor
    
    init(text : Binding<String> , placeholder : String = "Default..",placeholderColor : UIColor = .red) {
        self._text = text
        self.placeHolderColor = placeholderColor
        self.placeholder = placeholder
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeHolderColor])
        textField.attributedPlaceholder = placeHolder
        textField.delegate = context.coordinator
        return textField
    }
    
    
    //send data from swiftui to uikit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    //from uikit to swiftui
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func updatePlaceHolder(_ text : String) -> UITextFieldRepresentable{
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    class Coordinator : NSObject, UITextFieldDelegate{
        
        @Binding var text : String
        
        init(text : Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
}
