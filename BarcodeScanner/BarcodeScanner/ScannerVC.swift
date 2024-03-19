//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by mac on 15/03/24.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError : String {
    case invalidDeviceInput = "Something wrong with camera"
    case invalidScannedValue = "Scanned Value is not Valid"
}


protocol ScannerVCDelegate : AnyObject {
    func didFind(barcode : String)
    func didSurface (error : CameraError)
}


final class ScannerVC : UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewlayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate : ScannerVCDelegate?
    
    init(scannerDelegate : ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewlayer = previewlayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewlayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
            
        }
        
        let videoInput : AVCaptureDeviceInput
        
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }
        else{
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput)
        {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8,.ean13]
        }
        else{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewlayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewlayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewlayer!)
        
        captureSession.startRunning()
    }
    
}


extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
            
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
            
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
            
        }
        captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
        
        
        
    }
}
