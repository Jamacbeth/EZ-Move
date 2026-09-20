//
//  SuppliesViewModel.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

class SuppliesViewModel: ObservableObject {
    @Published var supplies: [SupplyItem] = []
    @Published var triggerAddSupplySheet = false
}
