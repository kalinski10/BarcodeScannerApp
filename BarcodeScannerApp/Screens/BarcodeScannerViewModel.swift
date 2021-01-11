//
//  BarcodeScannerViewModel.swift
//  BarcodeScannerApp
//
//  Created by Kalin Balabanov on 11/01/2021.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
}
