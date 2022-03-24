import Disk
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var isUnlocked = false

    var body: some Scene {
        WindowGroup {
            Group {
                if isUnlocked || !data.settings.useFaceID {
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
                            authenticate()
                        }
                } else {
                    Button("Unlock", action: authenticate)
                }
            }
        }
    }

    func authenticate() {
        if data.settings.useFaceID && !isUnlocked {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Unlock to acces your information."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    if success {
                        isUnlocked = true
                    } else {
                        isUnlocked = false
                    }
                }
            } else {
                print("FaceID not available.")
            }
        } else {
            isUnlocked = true
        }
    }
}
