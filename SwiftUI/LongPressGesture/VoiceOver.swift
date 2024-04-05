//
//  VoiceOver.swift
//  LongPressGesture
//
//  Created by mac on 05/04/24.
//

import SwiftUI

struct VoiceOver: View {
    
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack{
                        Text("Volume")
                        Spacer()
                        
                        Text(isActive ? "ON" : "OFF")
                    }
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                } header: {
                    Text("PREFERANCES")
                }
                
                Section{
                    
                    Button("Favorites")
                    {
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }

                    Text("Favorites")
                        .onTapGesture {
                            
                        }
                    
                } header: {
                    Text("APPLICATION")
                }
                
                VStack{
                    
                    Text("CONTENT")
                        .frame(maxWidth : .infinity,alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing : 8)
                        {
                            ForEach(0..<10){ x in
                                VStack{
                                    Image("stock")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                    
                                    Text("Item \(x)")
                                }
                                .onTapGesture {
                                    
                                }
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct VoiceOver_Previews: PreviewProvider {
    static var previews: some View {
        VoiceOver()
    }
}
