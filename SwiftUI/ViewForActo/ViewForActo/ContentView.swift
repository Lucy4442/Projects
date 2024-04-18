//
//  ContentView.swift
//  ViewForActo
//
//  Created by mac on 18/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment : .leading){
            
            Text("More Information")
                .font(.title3)
                .padding(.bottom,10)
            
            Text("Comedy")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom,10)
            VStack(alignment : .leading){
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                    Text("1hr 30mins")
                }
                HStack {
                    Image("Language")
                        .foregroundColor(.secondary)
                    Text("Hindi")
                }
                HStack {
                    Image("profiletick")
                    Text("16yrs +")
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
