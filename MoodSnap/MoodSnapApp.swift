import Disk
import HealthKit
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var health = HealthManager()
    @State private var isUnlocked = false

    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked, data: $data)
            } else {
                ContentView(data: $data, health: $health)
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
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                DispatchQueue.main.async {
                    isUnlocked = false
                    data.settings.firstUse = false
                    data.healthSnaps = health.healthSnaps
                    data.save() // add process???
                }
            }
            
            if value == .active {
                if HKHealthStore.isHealthDataAvailable() {
                    print("HealthKit is Available")
                    health.requestPermissions()
                    health.makeHealthSnaps(data: data)
                    data.healthSnaps = health.healthSnaps
                } else {
                    print("There is a problem accessing HealthKit")
                }
                DispatchQueue.global(qos: .userInteractive).async {
                    data.process()
                }
            }
            
            if value == .inactive {
                DispatchQueue.main.async {
                    isUnlocked = false
                }
            }
        }
    }
}
