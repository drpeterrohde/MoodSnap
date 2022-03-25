import SwiftUI
import Disk

struct DataStoreStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var settings: SettingsStruct = SettingsStruct()
    var uxState: UXStateStruct = UXStateStruct()
    var moodSnaps: [MoodSnapStruct] = []
    var healthData: HealthKitDataStruct = HealthKitDataStruct()
    var processedData: ProcessedDataStruct = ProcessedDataStruct()
    
    init() {
        self.id = UUID()
        self.settings = SettingsStruct()
        self.uxState = UXStateStruct()
        self.moodSnaps = makeDemoData()
        self.healthData = HealthKitDataStruct()
        self.process()
    }
    
    mutating func process() {
        self.processedData = processData(data: self)
    }
    
    func save() {
        do {
            try Disk.save(self, to: .documents, as: "data.json")
        } catch {
            print("Saving failed")
        }
    }
}
