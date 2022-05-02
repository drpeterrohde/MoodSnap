import Disk
import SwiftUI

/**
 Struct for main data storage type.
 */
struct DataStoreStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var settings: SettingsStruct = SettingsStruct()
    var uxState: UXStateStruct = UXStateStruct()
    var moodSnaps: [MoodSnapStruct] = makeIntroSnap()
    var healthSnaps: [HealthSnapStruct] = []
    var processedData: ProcessedDataStruct = ProcessedDataStruct()

    init() {
        id = UUID()
        settings = SettingsStruct()
        uxState = UXStateStruct()
        moodSnaps = makeIntroSnap()
        healthSnaps = []
        process()
    }

    /**
     Pre-process data.
     */
    mutating func process() {
        processedData = processData(data: self)
    }

    /**
     Dave `DataStoreStruct` to disk.
     */
    func save() {
        do {
            try Disk.save(self, to: .documents, as: "data.json")
        } catch {
            print("Saving failed")
        }
    }
}
