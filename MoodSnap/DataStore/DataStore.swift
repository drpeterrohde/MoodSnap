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
    
    /**
     Convert struct to class
     */
    func toClass() -> DataStoreClass {
        let dataStore: DataStoreClass = DataStoreClass()
        
        dataStore.id = self.id
        dataStore.version = self.version
        dataStore.settings = self.settings
        dataStore.uxState = self.uxState
        dataStore.moodSnaps = self.moodSnaps
        dataStore.healthSnaps = self.healthSnaps
        dataStore.processedData = self.processedData
        
        return dataStore
    }
}

/**
 Class for main data storage type.
 */
final class DataStoreClass: Identifiable, ObservableObject {
    var id: UUID = UUID()
    var version: Int = 1

    @Published var settings: SettingsStruct = SettingsStruct()
    @Published var uxState: UXStateStruct = UXStateStruct()
    @Published var moodSnaps: [MoodSnapStruct] = makeIntroSnap()
    @Published var healthSnaps: [HealthSnapStruct] = []
    @Published var processedData: ProcessedDataStruct = ProcessedDataStruct()
    @Published var processingTask: Task<Void, Never>? = nil
    var sequencedMoodSnaps: [[MoodSnapStruct]] = []
    var flattenedSequencedMoodSnaps: [MoodSnapStruct?] = []
    
    init() {
        id = UUID()
        settings = SettingsStruct()
        uxState = UXStateStruct()
        moodSnaps = makeIntroSnap()
        healthSnaps = []
        
        do {
            let retrieved = try Disk.retrieve(
                "data.json",
                from: .documents,
                as: DataStoreStruct.self)
            self.id = retrieved.id
            self.version = retrieved.version
            self.settings = retrieved.settings
            self.uxState = retrieved.uxState
            self.moodSnaps = retrieved.moodSnaps
            self.healthSnaps = retrieved.healthSnaps
            self.processedData = retrieved.processedData
        } catch {
            //print("Load failed")
        }
    }

    /**
     Process history
     */
    func processHistory() async -> Bool {
        let history = await newGenerateHistory(data: self)

        DispatchQueue.main.async {
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
        }
        
        return true
    }
    
    /**
     Process events
     */
    func processEvents() async -> Bool {
        let eventList = getEventsList(moodSnaps: self.moodSnaps)
        var eventButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< eventList.count {
            let dates = [eventList[i].1]
            var thisButterfly = averageTransientForDates(
                dates: dates,
                data: self,
                maxWindow: butterflyWindowLong)
            thisButterfly.activity = eventList[i].0
            thisButterfly.timestamp = eventList[i].1
            eventButterflies.append(thisButterfly)
        }
        let eventButterfliesUI = eventButterflies
        DispatchQueue.main.async {
            self.processedData.eventButterfly = eventButterfliesUI
        }
        return true
    }
    
    /**
     Process hashtags
     */
    func processHashtags() async -> Bool {
        let hashtags = getHashtags(data: self)
        var hashtagButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< hashtags.count {
            let dates = getDatesForHashtag(
                hashtag: hashtags[i],
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                data: self,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = hashtags[i]
            hashtagButterflies.append(thisButterfly)
        }
        let hashtagButterfliesUI = hashtagButterflies
        DispatchQueue.main.async {
            self.processedData.hashtagButterfly = hashtagButterfliesUI
        }
        return true
    }

    /**
     Process activities
     */
    func processActivities() async -> Bool {
        var activityButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< activityList.count {
            let dates = getDatesForType(
                type: .activity,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                data: self,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = activityList[i]
            activityButterflies.append(thisButterfly)
        }
        let activityButterfliesUI = activityButterflies
        DispatchQueue.main.async {
            self.processedData.activityButterfly = activityButterfliesUI
        }
        return true
    }
    
    /**
     Process symptoms
     */
    func processSymptoms() async -> Bool {
        var symptomButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< symptomList.count {
            let dates = getDatesForType(
                type: .symptom,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                data: self,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = symptomList[i]
            symptomButterflies.append(thisButterfly)
        }
        let symptomButterfliesUI = symptomButterflies
        DispatchQueue.main.async {
            self.processedData.symptomButterfly = symptomButterfliesUI
        }
        return true
    }
    
    /**
     Process social
     */
    func processSocial() async -> Bool {
        var socialButterflies: [ButterflyEntryStruct] = []
        for i in 0 ..< socialList.count {
            let dates = getDatesForType(
                type: .social,
                item: i,
                moodSnaps: self.moodSnaps)
            var thisButterfly = averageTransientForDates(
                dates: dates,
                data: self,
                maxWindow: butterflyWindowShort)
            thisButterfly.activity = socialList[i]
            socialButterflies.append(thisButterfly)
        }
        let socialButterfliesUI = socialButterflies
        DispatchQueue.main.async {
            self.processedData.socialButterfly = socialButterfliesUI
        }
        return true
    }
    
    /**
     Pre-process data.
     */
    func process() async {
        // Sequence MoodSnaps
        self.sequencedMoodSnaps = await sequenceMoodSnaps(moodSnaps: self.moodSnaps)
        self.flattenedSequencedMoodSnaps = await flattenSequence(sequence: self.sequencedMoodSnaps)
        
        // Processing
        async let historyComplete = processHistory()
        async let eventsComplete = processEvents()
        async let hashtagsComplete = processHashtags()
        async let activitiesComplete = processActivities()
        async let socialComplete = processSocial()
        async let symptomsComplete = processSymptoms()
        
        // Wait for all asynchronous threads to complete
        await _ = [historyComplete, eventsComplete, hashtagsComplete, activitiesComplete, socialComplete, symptomsComplete]
    }

    /**
     Start asynchronous processing of data
     */
    func startProcessing(priority: TaskPriority = .high) {
        self.save()
        
        if self.processingTask != nil {
            self.processingTask?.cancel()
        }
        
        DispatchQueue.main.async {
            self.processingTask = Task(priority: priority) {
                await self.process()
                DispatchQueue.main.async {
                    self.processingTask = nil
                }
            }
        }
    }
    
    /**
     Dave `DataStoreClass` to disk.
     */
    func save() {
        do {
            try Disk.save(self.toStruct(),
                          to: .documents,
                          as: "data.json")
        } catch {
            //print("Saving failed")
        }
    }
    
    /**
     Convert class to struct
     */
    func toStruct() -> DataStoreStruct {
        var dataStore: DataStoreStruct = DataStoreStruct()
        
        dataStore.id = self.id
        dataStore.version = self.version
        dataStore.settings = self.settings
        dataStore.uxState = self.uxState
        dataStore.moodSnaps = self.moodSnaps
        dataStore.healthSnaps = self.healthSnaps
        dataStore.processedData = self.processedData
        
        return dataStore
    }
}
