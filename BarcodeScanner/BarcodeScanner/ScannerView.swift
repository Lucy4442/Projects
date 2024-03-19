//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by mac on 15/03/24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode : String
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
   
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(scannerView: self)
        return coordinator
    }
    
    
    //Creating Coordinator
        
    
    final class Coordinator : NSObject, ScannerVCDelegate{
        
        private let scannerView : ScannerView
        
        init(scannerView : ScannerView)
        {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(scannedCode: .constant("123456"))
    }
}
