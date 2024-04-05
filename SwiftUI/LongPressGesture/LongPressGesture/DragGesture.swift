//
//  MagnificationGesture.swift
//  LongPressGesture
//
//  Created by mac on 01/04/24.
//

import SwiftUI

struct DragGesture: View {
    
    @State var textfield : String = ""
    @State var scrollToIndex : Int = 0
    
    var body: some View {
        VStack{
            
            TextField("Enter a # here...", text: $textfield)
                .frame(height: 55)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW")
            {
                withAnimation(.spring())
                {
                    if let index = Int(textfield)
                    {
                        scrollToIndex = index
                    }
                }
            }

            
            ScrollView{
                ScrollViewReader{ proxy in
                   
                    ForEach(0..<50) {index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height : 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring())
                        {
                            proxy.scrollTo(newValue, anchor: .top)

                        }
                    }
                }
                
                
            }
            
        }
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture()
    }
}
