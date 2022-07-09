import Disk
import SwiftUI

struct DataStoreStruct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    var settings: SettingsStruct = SettingsStruct()
    var uxState: UXStateStruct = UXStateStruct()
    var moodSnaps: [MoodSnapStruct] = makeIntroSnap()
    var healthSnaps: [HealthSnapStruct] = []
    var processedData: ProcessedDataStruct = ProcessedDataStruct()
}

/**
 Class for main data storage type.
 */
class DataStoreClass: ObservableObject, Identifiable, Codable {//, Hashable {
    var id: UUID = UUID()
    var version: Int = 1

    @Published var settings: SettingsStruct = SettingsStruct()
    @Published var uxState: UXStateStruct = UXStateStruct()
    @Published var moodSnaps: [MoodSnapStruct] = makeIntroSnap()
    @Published var healthSnaps: [HealthSnapStruct] = []
    @Published var processedData: ProcessedDataStruct = ProcessedDataStruct()

    /**
     Initialiser from disk or default to empty
     */
    init() {
        id = UUID()
        settings = SettingsStruct()
        uxState = UXStateStruct()
        moodSnaps = makeIntroSnap()
        healthSnaps = []
        
        process()
        
        do {
            let retrieved = try Disk.retrieve(
                "data.json",
                from: .documents,
                as: DataStoreStruct.self)
            
            id = retrieved.id
            version = retrieved.version
            settings = retrieved.settings
            uxState = retrieved.uxState
            moodSnaps = retrieved.moodSnaps
            healthSnaps = retrieved.healthSnaps
            processedData = retrieved.processedData
        } catch {
            print("Load failed")
        }
    }

    /**
     Encoding keys
     */
    enum CodingKeys: CodingKey {
       case id, version, settings, uxState, moodSnaps, healthSnaps, processedData
    }
    
    /**
     Encoder
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(version, forKey: .version)
        try container.encode(settings, forKey: .settings)
        try container.encode(uxState, forKey: .uxState)
        try container.encode(moodSnaps, forKey: .moodSnaps)
        try container.encode(healthSnaps, forKey: .healthSnaps)
        try container.encode(processedData, forKey: .processedData)
    }
    
    /**
     Initialiser usign decoding keys
     */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        version = try container.decode(Int.self, forKey: .version)
        settings = try container.decode(SettingsStruct.self, forKey: .settings)
        uxState = try container.decode(UXStateStruct.self, forKey: .uxState)
        moodSnaps = try container.decode([MoodSnapStruct].self, forKey: .id)
        healthSnaps = try container.decode([HealthSnapStruct].self, forKey: .healthSnaps)
        processedData = try container.decode(ProcessedDataStruct.self, forKey: .processedData)
    }
    
    /**
     Convert `DataStoreStruct` to `DataStoreClass`
     */
    func fromStruct(data: DataStoreStruct) {
        id = data.id
        version = data.version
        settings = data.settings
        uxState = data.uxState
        moodSnaps = data.moodSnaps
        healthSnaps = data.healthSnaps
        processedData = data.processedData
    }
    
    /**
     Pre-process data.
     */
    func process() {
        processedData = processData(data: self)
    }

    /**
     Dave `DataStoreClass` to disk.
     */
    func save() {
        do {
            try Disk.save(self, to: .documents, as: "data.json")
        } catch {
            print("Saving failed")
        }
    }
}
