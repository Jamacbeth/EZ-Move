import SwiftUI
import PhotosUI

struct RoomDetailView: View {
    @EnvironmentObject var roomsVM: RoomsViewModel
    @Binding var room: Room

    @State private var showingPhotoPicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(room.name)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            Text("\(room.packedBoxes) of \(room.totalBoxes) boxes packed")
                .foregroundColor(.gray)
                .font(.system(size: 16))

            if !room.boxes.isEmpty {
                Text("Packed Boxes")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(room.boxes) { box in
                            BoxCard(box: box, roomName: room.name)
                        }
                    }
                }
            } else {
                Text("No boxes scanned yet.")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }

            Spacer()

            Button(action: {
                showingPhotoPicker = true
            }) {
                Text("Take Photo of New Box")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(14)
            }
        }
        .padding(20)
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showingPhotoPicker, onDismiss: saveNewBox) {
            PhotoPicker(selectedImage: $selectedImage)
        }
    }

    func saveNewBox() {
        guard let image = selectedImage else { return }

        let newNumber = room.boxes.count + 1

        let newBox = BoxItem(
            label: "Box \(newNumber)",
            details: "Packed in \(room.name)",
            isPacked: true,
            image: image
        )

        room.boxes.append(newBox)
        room.totalBoxes += 1
        room.packedBoxes += 1

        roomsVM.updateRoom(room)
    }
}

