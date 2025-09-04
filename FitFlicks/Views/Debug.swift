import SwiftUI

// This is the view for the first tab. It saves a new value to UserDefaults.
struct SettingsView3: View {
   
    @AppStorage("username") var username: String = "Guest"

    var body: some View {
        VStack {
            Text("Current Username: \(username)")
            TextField("Enter new username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .padding()
        .tabItem {
            Label("Settings", systemImage: "gearshape")
        }
    }
}

// This is the view for the second tab. It reads the value from UserDefaults.
struct ProfileView: View {
    @AppStorage("username") var username: String = "Guest"

    var body: some View {
        VStack {
            Text("Welcome, \(username)!")
                .font(.largeTitle)
        }
        .tabItem {
            Label("Profile", systemImage: "person.fill")
        }
    }
}

// This is the main TabView container.
struct ContentView: View {
    var body: some View {
        TabView {
            SettingsView3()
            ProfileView()
        }
    }
}

// A simple preview provider for the TabView
#Preview {
    ContentView()
}

