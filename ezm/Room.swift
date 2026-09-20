import SwiftUI

struct Room: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var totalBoxes: Int
    var packedBoxes: Int

    // NEW: Store all boxes for this room
    var boxes: [BoxItem] = []
}

