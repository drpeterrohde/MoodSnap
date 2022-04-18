import Disk
import LocalAuthentication
import SwiftUI
import HealthKit
import HealthKitUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var isUnlocked = false
    private var healthManager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked, data: $data)
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

                        if HKHealthStore.isHealthDataAvailable() {
                            print("HealthKit is Available")
                            healthManager.requestPermissions()
                            let firstDate = getFirstDate(moodSnaps: data.moodSnaps)
                            healthManager.makeHealthSnapsForDates(startDate: firstDate, endDate: Date())
                        } else {
                            print("There is a problem accessing HealthKit")
                        }
                    }
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                isUnlocked = false
                data.settings.firstUse = false
                data.save()
            }
            if value == .active {
                authenticate()
                DispatchQueue.global(qos: .userInteractive).async {
                    data.process()
                    data.save()
                }
            }
        }
    }
    
    /**
     FaceID authentication
     */
    func authenticate() {
        // If using FaceID and locked
        if data.settings.useFaceID && !isUnlocked {
            let context = LAContext()
            var error: NSError?

            // Is biometric authentication available?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Unlock to acces MoodSnap."

                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                    if success {
                        // Authentication success
                        isUnlocked = true
                    } else {
                        // Authentication failure
                        isUnlocked = false
                    }
                }
            } else {
                // Biometrics not available
                isUnlocked = true
                data.settings.useFaceID = false
            }
        } else {
            isUnlocked = true
        }
    }
}
