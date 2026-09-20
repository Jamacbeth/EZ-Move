import SwiftUI

struct MainTabView: View {

    @State private var selectedTab = 0

    @StateObject var roomsVM = RoomsViewModel()
    @StateObject var suppliesVM = SuppliesViewModel()
    @StateObject var tasksVM = TasksViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {

            NavigationStack {
                ContentView(selectedTab: $selectedTab)
            }
            .environmentObject(roomsVM)
            .environmentObject(suppliesVM)
            .environmentObject(tasksVM)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            NavigationStack {
                RoomsView()
            }
            .environmentObject(roomsVM)
            .tabItem {
                Image(systemName: "bed.double.fill")
                Text("Rooms")
            }
            .tag(1)

            NavigationStack {
                SuppliesView()
            }
            .environmentObject(suppliesVM)
            .tabItem {
                Image(systemName: "shippingbox.fill")
                Text("Supplies")
            }
            .tag(2)

            NavigationStack {
                MeView()
            }
            .environmentObject(roomsVM)
            .environmentObject(suppliesVM)
            .environmentObject(tasksVM)
            .tabItem {
                Image(systemName: "person.fill")
                Text("Me")
            }
            .tag(3)
        }
    }
}

