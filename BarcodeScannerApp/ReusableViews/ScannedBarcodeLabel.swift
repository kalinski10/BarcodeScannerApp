//
//  BSText.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 08/01/2021.
//

import SwiftUI

struct ScannedBarcodeLabel: View {
    var body: some View {
        Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
            .font(.title)
            .foregroundColor(Color(.label))
    }
}
