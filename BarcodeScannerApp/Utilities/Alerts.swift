//
//  Alerts.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 11/01/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid device input",
                                       message: "Something is wrong with the camera. We are unable to capture the input",
                                       dismissButton: .default(Text("Ok")))
    
    static let invalidScanValue = AlertItem(title: "Invalid scan value",
                                     message: "The value scanned is not valid. This app scanns EAN-8 & EAN-13",
                                     dismissButton: .default(Text("Ok")))
}

