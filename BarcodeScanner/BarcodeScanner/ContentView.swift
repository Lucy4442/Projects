//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by mac on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scannedCode = ""
    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $scannedCode)
                    .frame(height: 300)
                    .padding(.bottom)
                    .background(.gray)
                
                
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding(.top,50)
                
                
                Text("Not Yet Scanned")
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
