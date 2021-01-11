//
//  ScannerVC.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 10/01/2021.
//

import UIKit
import AVFoundation

enum CamerError {
    case invalidDeviceInput
    case invalidScanValue
}

// MARK: - Protocols

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CamerError)
}


final class ScannerVC: UIViewController {
   
// MARK: - Properties
    
    let captureSession              = AVCaptureSession()
    var previewLayer:               AVCaptureVideoPreviewLayer?
    weak var scannerDelegete:       ScannerVCDelegate?
    
// MARK: - Initialisers
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegete = scannerDelegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCaptureSession()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegete?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    
// MARK: - Private functions
    
    private func setUpCaptureSession() {
        // check if we have video capture device
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegete?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do { try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice) }
        catch {
            scannerDelegete?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        // check if we can add the video input
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegete?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        // check if we can add output
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        }
        else {
            scannerDelegete?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        // configure preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
}

// MARK: - Extensions

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard let object = metadataObjects.first else {
            scannerDelegete?.didSurface(error: .invalidScanValue)
             return
        }
        
        guard let machineReadableOnject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegete?.didSurface(error: .invalidScanValue)
            return
        }
        
        guard let barcode = machineReadableOnject.stringValue else {
            scannerDelegete?.didSurface(error: .invalidScanValue)
            return
        }
        
        scannerDelegete?.didFind(barcode: barcode)
    }
    
}
