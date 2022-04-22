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
                            healthManager.makeHealthSnaps(data: data)
                            data.healthSnaps = healthManager.healthSnaps
                        } else {
                            print("There is a problem accessing HealthKit")
                        }
                    }
            }
        }.onChange(of: scenePhase) { value in
            if value == .background {
                isUnlocked = false
                data.settings.firstUse = false
                data.healthSnaps = healthManager.healthSnaps
                data.save() // add process???
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









//        let samplesE = getWeightMoodDistribution(type: .elevation, data: data)
//        let samplesD = getWeightMoodDistribution(type: .depression, data: data)
//        let samplesA = getWeightMoodDistribution(type: .anxiety, data: data)
//        let samplesI = getWeightMoodDistribution(type: .irritability, data: data)
//
//        let scatterE = makeLineData(x: samplesE.0, y: samplesE.1)
//        let scatterD = makeLineData(x: samplesD.0, y: samplesD.1)
//        let scatterA = makeLineData(x: samplesA.0, y: samplesA.1)
//        let scatterI = makeLineData(x: samplesI.0, y: samplesI.1)
//
//        let color = moodUIColors(settings: data.settings)
//
//        VStack(alignment: .center) {
//            if (samplesE.0.count == 0) {
//                Text("Insufficient data")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            } else {
//                ScatterChart(entries: scatterE, color: color[0])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterD, color: color[1])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterA, color: color[2])
//                    .frame(height: 170)
//                ScatterChart(entries: scatterI, color: color[3])
//                    .frame(height: 170)
//                Text("Weight")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding([.top], -10)
//            }
//        }
