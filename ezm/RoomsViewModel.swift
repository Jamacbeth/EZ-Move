//
//  RoomsViewModel.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

class RoomsViewModel: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var triggerAddRoomSheet = false

    func updateRoom(_ room: Room) {
        if let index = rooms.firstIndex(where: { $0.id == room.id }) {
            rooms[index] = room
        }
    }
}
