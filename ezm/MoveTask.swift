//
//  MoveTask.swift
//  ezm
//
//  Created by Jake on 2026-07-31.
//

import SwiftUI

struct MoveTask: Identifiable {
    let id = UUID()
    var title: String
    var isComplete: Bool = false
}
