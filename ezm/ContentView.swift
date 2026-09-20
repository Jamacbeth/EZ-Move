import SwiftUI

struct ContentView: View {

    @EnvironmentObject var roomsVM: RoomsViewModel
    @EnvironmentObject var suppliesVM: SuppliesViewModel
    @EnvironmentObject var tasksVM: TasksViewModel

    @Binding var selectedTab: Int
    @AppStorage("moveDate") private var moveDate: Double = Date().timeIntervalSince1970

    @State private var showConfetti = false

    var body: some View {
        ZStack {
            mainContent

            if showConfetti {
                ConfettiView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            if overallProgress() >= 1.0 && !showConfetti {
                triggerConfetti()
            }
        }
        .onChange(of: overallProgress()) {
            if overallProgress() >= 1.0 && !showConfetti {
                triggerConfetti()
            }
        }
    }

    func triggerConfetti() {
        showConfetti = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showConfetti = false
            }
        }
    }

    // ⭐ SCROLLING FIX APPLIED HERE ⭐
    var mainContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                VStack(spacing: 4) {
                    Text("EZ Move")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)

                    Text("Moving made simple")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)

                // MARK: - Move Progress
                VStack(spacing: 8) {
                    Text("Move Progress")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    Text("\(Int(overallProgress() * 100))%")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)

                    Text("📦")
                        .font(.system(size: 36))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                .cornerRadius(18)

                // MARK: - Move Date Selector
                VStack(spacing: 10) {
                    Text("Move Date")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)

                    DatePicker(
                        "",
                        selection: Binding(
                            get: { Date(timeIntervalSince1970: moveDate) },
                            set: { moveDate = $0.timeIntervalSince1970 }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .foregroundColor(.white)
                    .tint(.white)

                    let daysLeft = Calendar.current.dateComponents(
                        [.day],
                        from: Date(),
                        to: Date(timeIntervalSince1970: moveDate)
                    ).day ?? 0

                    Text("\(daysLeft) days left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.18, green: 0.18, blue: 0.20))
                .cornerRadius(18)

                // MARK: - Quick Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Quick Actions")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    HStack(spacing: 16) {

                        Button {
                            selectedTab = 1
                            roomsVM.triggerAddRoomSheet = true
                        } label: {
                            QuickActionCard(
                                icon: "🏠",
                                title: "Add Rooms",
                                subtitle: "Bedroom, Kitchen..."
                            )
                        }

                        Button {
                            selectedTab = 2
                            suppliesVM.triggerAddSupplySheet = true
                        } label: {
                            QuickActionCard(
                                icon: "📦",
                                title: "Add Supplies",
                                subtitle: "Boxes, Tape, etc."
                            )
                        }
                    }
                }

                // MARK: - My Rooms
                if !roomsVM.rooms.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("My Rooms")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)

                        ForEach(roomsVM.rooms) { room in
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
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 40) // prevents last room from being cut off
        }
        .background(Color.black.ignoresSafeArea())
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

struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(icon)
                .font(.system(size: 24))
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(red: 0.12, green: 0.12, blue: 0.14))
        .cornerRadius(18)
    }
}

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = []

    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onAppear {
            generateConfetti()
        }
    }

    func generateConfetti() {
        particles = (0..<40).map { _ in
            ConfettiParticle(
                position: CGPoint(x: CGFloat.random(in: 0...400),
                                  y: CGFloat.random(in: 0...0)),
                size: CGFloat.random(in: 8...16),
                color: [
                    .red, .yellow, .green, .blue, .purple, .orange
                ].randomElement()!,
                opacity: 1.0
            )
        }

        withAnimation(.easeOut(duration: 2)) {
            for i in particles.indices {
                particles[i].position.y += CGFloat.random(in: 300...600)
                particles[i].opacity = 0
            }
        }
    }
}

struct ConfettiParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: Double
}

