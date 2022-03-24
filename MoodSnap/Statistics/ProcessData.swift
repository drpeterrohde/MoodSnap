import SwiftUI

/**
 Struct for processed data.
 */
struct ProcessedDataStruct: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    
    // Mood history
    var levelE: [CGFloat?] = []
    var levelD: [CGFloat?] = []
    var levelA: [CGFloat?] = []
    var levelI: [CGFloat?] = []
    
    // Sliding average history
    var averageE: [CGFloat?] = []
    var averageD: [CGFloat?] = []
    var averageA: [CGFloat?] = []
    var averageI: [CGFloat?] = []
    
    // Volatility history
    var volatilityE: [CGFloat?] = []
    var volatilityD: [CGFloat?] = []
    var volatilityA: [CGFloat?] = []
    var volatilityI: [CGFloat?] = []
    
    // Butterflies
    var activityButterfly: [ButterflyEntryStruct] = []
    var socialButterfly: [ButterflyEntryStruct] = []
    var symptomButterfly: [ButterflyEntryStruct] = []
    var eventButterfly: [ButterflyEntryStruct] = []
    var hashtagButterfly: [ButterflyEntryStruct] = []
}

/**
 Process all `MoodSnapStruct` entries from `data` into a `ProcessedDataStruct`.
 */
func processData(data: DataStoreStruct) -> ProcessedDataStruct {
    var processedData = ProcessedDataStruct()
    let history = generateHistory(data: data)
    let eventList = getEventsList(moodSnaps: data.moodSnaps)
    
    // Mood history
    processedData.levelE = history.levelE
    processedData.levelD = history.levelD
    processedData.levelA = history.levelA
    processedData.levelI = history.levelI
    
    // Sliding average history
    processedData.averageE = history.averageE
    processedData.averageD = history.averageD
    processedData.averageA = history.averageA
    processedData.averageI = history.averageI
    
    // Volatility history
    processedData.volatilityE = history.volatilityE
    processedData.volatilityD = history.volatilityD
    processedData.volatilityA = history.volatilityA
    processedData.volatilityI = history.volatilityI
    
    // Butterflies
    
    // Event
    for i in 0..<eventList.count {
        let dates = [eventList[i].1]
        var thisButterfly = averageButterflyForDates(
            dates: dates,
            moodSnaps: data.moodSnaps,
            maxWindow: butterflyWindowLong)
        thisButterfly.activity = eventList[i].0
        thisButterfly.timestamp = eventList[i].1
        processedData.eventButterfly.append(thisButterfly)
    }
    
    // Hashtags
    let hashtags = getHashtags(moodSnaps: data.moodSnaps)
    for i in 0..<hashtags.count {
        let dates = getDatesForHashtag(
            hashtag: hashtags[i],
            moodSnaps: data.moodSnaps)
        var thisButterfly = averageButterflyForDates(
            dates: dates,
            moodSnaps: data.moodSnaps,
            maxWindow: butterflyWindowShort)
        thisButterfly.activity = hashtags[i]
        processedData.hashtagButterfly.append(thisButterfly)
    }
    
    // Activity
    for i in 0..<activityList.count {
        let dates = getDatesForType(
            type: .activity,
            item: i,
            moodSnaps: data.moodSnaps)
        var thisButterfly = averageButterflyForDates(
            dates: dates,
            moodSnaps: data.moodSnaps,
            maxWindow: butterflyWindowShort)
        thisButterfly.activity = activityList[i]
        processedData.activityButterfly.append(thisButterfly)
    }
    
    // Social
    for i in 0..<socialList.count {
        let dates = getDatesForType(
            type: .social,
            item: i,
            moodSnaps: data.moodSnaps)
        var thisButterfly = averageButterflyForDates(
            dates: dates,
            moodSnaps: data.moodSnaps,
            maxWindow: butterflyWindowShort)
        thisButterfly.activity = socialList[i]
        processedData.socialButterfly.append(thisButterfly)
    }
    
    // Symptom
    for i in 0..<symptomList.count {
        let dates = getDatesForType(
            type: .symptom,
            item: i,
            moodSnaps: data.moodSnaps)
        var thisButterfly = averageButterflyForDates(
            dates: dates,
            moodSnaps: data.moodSnaps,
            maxWindow: butterflyWindowShort)
        thisButterfly.activity = symptomList[i]
        processedData.symptomButterfly.append(thisButterfly)
    }
    
    return processedData
}
