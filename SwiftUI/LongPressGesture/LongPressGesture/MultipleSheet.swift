//
//  MultipleSheet.swift
//  LongPressGesture
//
//  Created by mac on 02/04/24.
//

import SwiftUI

struct RandomModel : Identifiable{
    let id = UUID().uuidString
    let title : String
}


struct MultipleSheet: View {
    
    @State var selectedModel : RandomModel? = nil
    
    var body: some View {
        ScrollView{
            VStack(spacing : 20)
            {
                ForEach(0..<50){ index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "You click on Button \(index)")
                    }
                }
            }
            .frame(maxWidth : .infinity)
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
        
    }
}

struct NextScreen : View {
    
    let selectedModel : RandomModel
    var body : some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


struct MultipleSheet_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheet()
    }
}
