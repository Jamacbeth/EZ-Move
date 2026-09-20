import SwiftUI

let availableRooms: [String] = [
    "Living Room", "Master Bedroom",
    "Bedroom 1", "Bedroom 2", "Bedroom 3",
    "Bedroom 4", "Bedroom 5", "Bedroom 6", "Bedroom 7",
    "Kitchen", "Bathroom"
]

struct RoomsView: View {
    @EnvironmentObject var roomsVM: RoomsViewModel
    @State private var showingAddRoom = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack {
                Text("Rooms")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                Button {
                    showingAddRoom = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            .padding(.top, 20)

            if roomsVM.rooms.isEmpty {
                Text("No rooms added yet.")
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            } else {
                ForEach(roomsVM.rooms.indices, id: \.self) { index in
                    let room = roomsVM.rooms[index]

                    NavigationLink {
                        RoomDetailView(room: $roomsVM.rooms[index])
                    } label: {
                        RoomCard(
                            icon: room.icon,
                            title: room.name,
                            subtitle: "\(room.packedBoxes) of \(room.totalBoxes) boxes packed"
                        )
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showingAddRoom) {
            AddRoomSheet().environmentObject(roomsVM)
        }
        .onChange(of: roomsVM.triggerAddRoomSheet) { newValue in
            if newValue {
                showingAddRoom = true
                roomsVM.triggerAddRoomSheet = false
            }
        }
    }
}

struct AddRoomSheet: View {
    @EnvironmentObject var roomsVM: RoomsViewModel

    var body: some View {
        NavigationView {
            List(availableRooms, id: \.self) { roomName in
                Button {
                    roomsVM.rooms.append(
                        Room(
                            name: roomName,
                            icon: iconForRoom(roomName),
                            totalBoxes: 0,
                            packedBoxes: 0
                        )
                    )
                } label: {
                    HStack {
                        Text(iconForRoom(roomName))
                            .font(.system(size: 22))

                        Text(roomName)
                            .font(.system(size: 18))

                        Spacer()

                        Text("0 boxes")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            .navigationTitle("Add Room")
        }
    }
}

func iconForRoom(_ name: String) -> String {
    switch name {
    case "Living Room": return "🛋️"
    case "Master Bedroom": return "🛏️"
    case "Kitchen": return "🍳"
    case "Bathroom": return "🛁"
    default: return "🛏️"
    }
}

