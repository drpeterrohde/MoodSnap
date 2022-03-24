import Disk
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
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
                            print("Load successful")
                        } catch {
                            print("Load failed")
                        }
                    }
            }
        }
    }
}
