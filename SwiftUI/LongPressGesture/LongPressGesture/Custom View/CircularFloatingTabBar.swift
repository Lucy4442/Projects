//
//  CircularFloatingTabBar.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var index = 0
    
    var body: some View {
        
        VStack(spacing: 0){
            
            ZStack{
                
                if self.index == 0{
                    
                    Color.black.opacity(0.05)
                }
                else if self.index == 1{
                    
                    Color.yellow
                }
                else if self.index == 2{
                    
                    Color.blue
                }
                else{
                    
                    Color.orange
                }
            }
            
            CircleTab(index: self.$index)
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CircleTab : View {
    
    @Binding var index : Int
    
    var body : some View{
        
        
        HStack{
            
            Button(action: {
                
                self.index = 0
                
            }) {
                
                VStack{
                    
                    if self.index != 0{
                        
                        Image("home").foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("home")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Home").foregroundColor(Color.black.opacity(0.7))
                    }
                }
                
                
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
                self.index = 1
                
            }) {
                
                VStack{
                    
                    if self.index != 1{
                        
                        Image("search").foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("search")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Search").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
                self.index = 2
                
            }) {
                
                VStack{
                    
                    if self.index != 2{
                        
                        Image("heart").foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("heart")
                            .resizable()
                            .frame(width: 24, height: 22)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Likes").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
                self.index = 3
                
            }) {
                
               VStack{
                   
                   if self.index != 3{
                       
                       Image("person").foregroundColor(Color.black.opacity(0.2))
                   }
                   else{
                       
                       Image("person")
                           .resizable()
                           .frame(width: 25, height: 23)
                           .foregroundColor(.white)
                           .padding()
                           .background(Color.red)
                           .clipShape(Circle())
                           .offset(y: -20)
                           .padding(.bottom, -20)
                       
                       Text("Account").foregroundColor(Color.black.opacity(0.7))
                   }
               }
            }
            
        }.padding(.vertical,-10)
        .padding(.horizontal, 25)
        .background(Color.white)
        .animation(.easeInOut)
    }
}
