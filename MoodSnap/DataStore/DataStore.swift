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

    mutating func processHistory() async -> Bool {
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
        
        return true
    }
    
    mutating func processEvents() async -> Bool {
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
        
        return true
    }
    
    mutating func processActivities() async -> Bool {
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
        
        return true
    }
    
    mutating func processSymptoms() async -> Bool {
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
        
        return true
    }
    
    mutating func processSocial() async -> Bool {
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
        
        return true
    }
    
    mutating func processHashtags() async -> Bool {
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
        
        return true
    }
    
    /**
     Pre-process data.
     */
    mutating func process() async {
        let dummy1 = await self.processHistory()
        let dummy2 = await self.processEvents()
        let dummy3 = await self.processActivities()
        let dummy4 = await self.processSymptoms()
        let dummy5 = await self.processSocial()
        let dummy6 = await self.processHashtags()
        
        //await [dummy1, dummy2, dummy3, dummy4, dummy5, dummy6]
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
