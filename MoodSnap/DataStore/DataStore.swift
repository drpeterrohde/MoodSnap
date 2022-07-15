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
        
        do {
            let retrieved = try Disk.retrieve(
                "data.json",
                from: .documents,
                as: DataStoreStruct.self)
            self = retrieved
        } catch {
            print("Load failed")
        }
    }

    /**
     Pre-process data.
     */
    mutating func process() {
        let history = generateHistory(data: self)
        
        // Mood history
        self.processedData.levelE = history.levelE
        self.processedData.levelD = history.levelD
        self.processedData.levelA = history.levelA
        self.processedData.levelI = history.levelI

        // Sliding average history
        self.processedData.averageE = history.averageE
        self.processedData.averageD = history.averageD
        self.processedData.averageA = history.averageA
        self.processedData.averageI = history.averageI

        // Volatility history
        self.processedData.volatilityE = history.volatilityE
        self.processedData.volatilityD = history.volatilityD
        self.processedData.volatilityA = history.volatilityA
        self.processedData.volatilityI = history.volatilityI

        // Butterflies

        // Event
        let eventList = getEventsList(moodSnaps: self.moodSnaps)
        for i in 0 ..< eventList.count {
            let dates = [eventList[i].1]
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowLong)
            thisButterfly.activity = eventList[i].0
            thisButterfly.timestamp = eventList[i].1
            self.processedData.eventButterfly.append(thisButterfly)
        }

        // Hashtags
        let hashtags = getHashtags(data: self)
        for i in 0 ..< hashtags.count {
            let dates = getDatesForHashtag(
                hashtag: hashtags[i],
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = hashtags[i]
            self.processedData.hashtagButterfly.append(thisButterfly)
        }

        // Activity
        for i in 0 ..< activityList.count {
            let dates = getDatesForType(
                type: .activity,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = activityList[i]
            self.processedData.activityButterfly.append(thisButterfly)
        }

        // Social
        for i in 0 ..< socialList.count {
            let dates = getDatesForType(
                type: .social,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = socialList[i]
            self.processedData.socialButterfly.append(thisButterfly)
        }

        // Symptom
        for i in 0 ..< symptomList.count {
            let dates = getDatesForType(
                type: .symptom,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = symptomList[i]
            self.processedData.symptomButterfly.append(thisButterfly)
        }
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
