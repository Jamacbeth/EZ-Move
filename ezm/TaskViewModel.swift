//
//  TaskViewModel.swift
//  ezm
//
//  Created by Jake on 2026-06-26.
//

import SwiftUI

class TasksViewModel: ObservableObject {
    @Published var extraTasks: [MoveTask] = [
        MoveTask(title: "Change mailing address"),
        MoveTask(title: "Schedule movers"),
        MoveTask(title: "Pack fragile items"),
        MoveTask(title: "Clean old apartment"),
        MoveTask(title: "Confirm moving truck"),
        MoveTask(title: "Label all boxes")
    ]
}
