import SwiftUI

struct MeView: View {

    @EnvironmentObject var roomsVM: RoomsViewModel
    @EnvironmentObject var suppliesVM: SuppliesViewModel
    @EnvironmentObject var tasksVM: TasksViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("My Move Tasks")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)

                VStack(spacing: 12) {
                    ProgressRing(progress: overallProgress())
                        .frame(width: 120, height: 120)

                    Text("\(Int(overallProgress() * 100))% Complete")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 16) {

                    TaskRow(
                        title: "Pack Rooms",
                        detail: "\(packedRooms()) of \(roomsVM.rooms.count) rooms started",
                        isComplete: packedRooms() == roomsVM.rooms.count
                    )

                    TaskRow(
                        title: "Get Supplies",
                        detail: "\(suppliesVM.supplies.count) of 6 supplies acquired",
                        isComplete: suppliesVM.supplies.count >= 6
                    )

                    Text("Move Checklist")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    ForEach(tasksVM.extraTasks.indices, id: \.self) { index in
                        let task = tasksVM.extraTasks[index]

                        Button {
                            tasksVM.extraTasks[index].isComplete.toggle()
                        } label: {
                            HStack {
                                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isComplete ? .green : .gray)
                                    .font(.system(size: 22))

                                Text(task.title)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))

                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 0.09, green: 0.09, blue: 0.11))
                            .cornerRadius(12)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }

    func packedRooms() -> Int {
        roomsVM.rooms.filter { $0.packedBoxes > 0 }.count
    }

    func overallProgress() -> Double {

        let roomProgress: Double = {
            if roomsVM.rooms.isEmpty { return 0 }
            let values = roomsVM.rooms.map { room in
                room.totalBoxes == 0 ? 0 : Double(room.packedBoxes) / Double(room.totalBoxes)
            }
            return values.reduce(0, +) / Double(values.count)
        }()

        let supplyProgress: Double = {
            Double(suppliesVM.supplies.count) / 6.0
        }()

        let taskProgress: Double = {
            let completed = tasksVM.extraTasks.filter { $0.isComplete }.count
            return Double(completed) / Double(tasksVM.extraTasks.count)
        }()

        return (roomProgress + supplyProgress + taskProgress) / 3
    }
}

struct TaskRow: View {
    let title: String
    let detail: String
    let isComplete: Bool

    var body: some View {
        HStack {
            Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isComplete ? .green : .gray)
                .font(.system(size: 24))

            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))

                Text(detail)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }

            Spacer()
        }
        .padding()
        .background(Color(red: 0.09, green: 0.09, blue: 0.11))
        .cornerRadius(16)
    }
}

struct ProgressRing: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 12)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Text("\(Int(progress * 100))%")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .green : .gray)
                .font(.system(size: 22))
                .onTapGesture { configuration.isOn.toggle() }

            configuration.label
        }
        .padding()
        .background(Color(red: 0.09, green: 0.09, blue: 0.11))
        .cornerRadius(12)
    }
}

