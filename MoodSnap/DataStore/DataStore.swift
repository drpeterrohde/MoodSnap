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
        
        //???process()
        
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
    mutating func process() async {
        let history = await generateHistory(data: self)
        
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
        var eventButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< eventList.count {
            let dates = [eventList[i].1]
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowLong)
            thisButterfly.activity = eventList[i].0
            thisButterfly.timestamp = eventList[i].1
            eventButterflies.append(thisButterfly)
        }
        self.processedData.eventButterfly = eventButterflies

        // Hashtags
        let hashtags = getHashtags(data: self)
        var hashtagButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< hashtags.count {
            let dates = getDatesForHashtag(
                hashtag: hashtags[i],
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                moodSnaps: self.moodSnaps,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = hashtags[i]
            hashtagButterflies.append(thisButterfly)
        }
        self.processedData.hashtagButterfly = hashtagButterflies

        // Activity
        var activityButterflies: [ButterflyEntryStruct] = []
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
            activityButterflies.append(thisButterfly)
        }
        self.processedData.activityButterfly = activityButterflies

        // Social
        var socialButterflies: [ButterflyEntryStruct] = []
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
            socialButterflies.append(thisButterfly)
        }
        self.processedData.socialButterfly = socialButterflies

        // Symptom
        var symptomButterflies: [ButterflyEntryStruct] = []
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
            symptomButterflies.append(thisButterfly)
        }
        self.processedData.symptomButterfly = symptomButterflies
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
