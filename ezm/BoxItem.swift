//
//  BoxItem.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

struct BoxItem: Identifiable {
    let id = UUID()
    let label: String
    let details: String
    var isPacked: Bool = false

    // NEW: Optional photo for this box
    var image: UIImage? = nil
}
