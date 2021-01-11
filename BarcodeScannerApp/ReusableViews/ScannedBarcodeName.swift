//
//  ScannedBarcodeName.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 08/01/2021.
//

import SwiftUI

struct ScannedBarcodeName: View {
    
    @Binding var scannedCode: String
    
    var body: some View {
        Text(scannedCode.isEmpty ? "Not yet scanned" : scannedCode)
            .font(.largeTitle)
            .bold()
            .foregroundColor(scannedCode.isEmpty ? Color(.systemRed) : Color(.systemGreen))
    }
}
