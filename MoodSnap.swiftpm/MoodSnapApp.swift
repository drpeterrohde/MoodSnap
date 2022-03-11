import SwiftUI

@main
struct MoodSnapApp: App {
    @State private var data: DataStoreStruct = DataStoreStruct()
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: $data)
        }
    }
}
