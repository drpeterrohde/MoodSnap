import Disk
import HealthKit
import LocalAuthentication
import SwiftUI

@main
struct MoodSnapApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var data: DataStoreClass = DataStoreClass()
    @StateObject private var health: HealthManager = HealthManager()
    @State private var isUnlocked: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !isUnlocked && data.settings.useFaceID {
                UnlockView(isUnlocked: $isUnlocked)
                    .environmentObject(data)
            } else {
                ContentView()
                    .environmentObject(data)
                    .environmentObject(health)
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                DispatchQueue.main.async {
                    isUnlocked = false
                    data.settings.firstUse = false
                    data.save()
                }
            }
            
            if value == .active {
                hapticPrepare(data: data)
                data.startProcessing()
                if data.settings.useHealthKit {
                    if HKHealthStore.isHealthDataAvailable() {
                        health.requestPermissions()
                        Task {
                            await health.makeHealthSnaps(data: data)
                        }
                    }
                }
                StoreReviewHelper.incrementAppOpenedCount()
                StoreReviewHelper.checkAndAskForReview()
            }
            
            if value == .inactive {
                DispatchQueue.main.async {
                    isUnlocked = false
                    data.settings.firstUse = false
                    data.save()
                }
            }
        }
    }
}
