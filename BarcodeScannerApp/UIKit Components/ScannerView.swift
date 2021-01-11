//
//  ScannerView.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 10/01/2021.
//

import SwiftUI


struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerVC {
        // initialise the vc
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
// MARK: - Coordinator
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            print(barcode)
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CamerError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            
            case .invalidScanValue:
                scannerView.alertItem = AlertContext.invalidScanValue
            }
        }
    }
    
}
