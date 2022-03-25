import Disk
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var isUnlocked = false

    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked, data: data)
            } else {
                ContentView(data: $data)
                    .onAppear {
                        do {
                            let retrieved = try Disk.retrieve(
                                "data.json",
                                from: .documents,
                                as: DataStoreStruct.self)
                            data = retrieved
                        } catch {
                            print("Load failed")
                        }
                    }
                    .onChange(of: scenePhase) { value in
                        if value == .background {
                            isUnlocked = false
                        }
                    }
            }
        }
    }
}
