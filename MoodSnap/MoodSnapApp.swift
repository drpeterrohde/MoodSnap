import Disk
import HealthKit
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var data: DataStoreStruct = DataStoreStruct()
    @State private var health: HealthManager = HealthManager()
    @State private var isUnlocked: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked, data: $data)
            } else {
                ContentView(data: $data, health: $health)
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                DispatchQueue.main.async {
                    isUnlocked = false
                    data.settings.firstUse = false
                    data.healthSnaps = health.healthSnaps
                    data.save()
//                    DispatchQueue.global(qos: .background).async {
//                        data.process()
//                    } ???
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
