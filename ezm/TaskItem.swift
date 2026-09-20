//
//  TaskItem.swift
//  ezm
//
//  Created by Jake on 2026-06-26.
//

import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    var note: String? = nil
    var isComplete: Bool = false
}
