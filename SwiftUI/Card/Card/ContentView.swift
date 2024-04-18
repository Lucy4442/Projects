//
//  ContentView.swift
//  Card
//
//  Created by mac on 18/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment : .top){
            Color.purple
                .ignoresSafeArea()
            VStack {
                VStack(){
                    Rectangle()
                        .frame(width: 116, height: 120, alignment: .top)
                        .cornerRadius(12)
                        .padding(.top,4)
                        .overlay {
                            Circle()
                                .fill(.white)
                                .frame(width: 38, height: 38)
                                .offset(y: 60)
                        }
                    
                    Spacer()
                    Text("1 Year")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
                
                Text("fjdf")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
           
        }
        .frame(width: 120, height: 170)
        .cornerRadius(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
