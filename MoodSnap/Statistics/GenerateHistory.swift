import SwiftUI

/**
 Sequence MoodSnaps into chronological array.
 ???
 */
@inline(__always) func sequenceMoodSnaps(moodSnaps: [MoodSnapStruct]) async -> [[MoodSnapStruct]] {
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)
    let length: Int = Calendar.current.numberOfDaysBetween(from: earliest, to: Date()) + 1
    var sequence: [[MoodSnapStruct]] = Array(repeating: [], count: length)
    
    for moodSnap in moodSnaps {
        let offset = length - 1 - Calendar.current.numberOfDaysBetween(from: moodSnap.timestamp, to: Date())
        sequence[offset].append(moodSnap)
    }
    
    return sequence
}

/**
 Flatten sequence of MoodSnaps on a per-day basis.
 */
@inline(__always) func flattenSequence(sequence: [[MoodSnapStruct]]) async -> [MoodSnapStruct?] {
    var flattenedSequence: [MoodSnapStruct?] = []
    
    for snaps in sequence {
        let flattened: MoodSnapStruct? = mergeMoodSnaps(moodSnaps: snaps)
        flattenedSequence.append(flattened)
    }
    
    return flattenedSequence
}

/**
 Generate the complete history of mood levels, moving averages and moving volatilities from `data`.
 */
//@inline(__always) func generateHistory(data: DataStoreClass) async -> HistoryStruct {
//    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
//    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)
//    var statsHistory: [StatsEntryStruct] = []
//
//    while date >= earliest {
//        var thisStats = StatsEntryStruct()
//
//        let todaySnaps = getMoodSnapsByDate(
//            moodSnaps: data.moodSnaps,
//            date: date,
//            flatten: false)
//        let windowSnaps = getMoodSnapsByDateWindow(
//            moodSnaps: data.moodSnaps,
//            date: date,
//            windowStart: -data.settings.slidingWindowSize + 1,
//            windowEnd: 0,
//            flatten: false)
//        let mergedWindowSnaps = getMoodSnapsByDateWindow(
//            moodSnaps: data.moodSnaps,
//            date: date,
//            windowStart: -data.settings.slidingWindowSize + 1,
//            windowEnd: 0,
//            flatten: true)
//
//        if let todaySnap = mergeMoodSnaps(moodSnaps: todaySnaps) {
//            thisStats.levelE = todaySnap.elevation
//            thisStats.levelD = todaySnap.depression
//            thisStats.levelA = todaySnap.anxiety
//            thisStats.levelI = todaySnap.irritability
//        }
//
//        let thisAverages = average(moodSnaps: mergedWindowSnaps)
//        thisStats.averageE = thisAverages[0]
//        thisStats.averageD = thisAverages[1]
//        thisStats.averageA = thisAverages[2]
//        thisStats.averageI = thisAverages[3]
//
//        let thisVolatilies = volatility(moodSnaps: windowSnaps)
//        thisStats.volatilityE = thisVolatilies[0]
//        thisStats.volatilityD = thisVolatilies[1]
//        thisStats.volatilityA = thisVolatilies[2]
//        thisStats.volatilityI = thisVolatilies[3]
//
//        statsHistory.append(thisStats)
//        date = date.addDays(days: -1)
//    }
//
//    statsHistory = statsHistory.reversed()
//
//    var history = HistoryStruct()
//
//    for stats in statsHistory {
//        history.levelE.append(stats.levelE)
//        history.levelD.append(stats.levelD)
//        history.levelA.append(stats.levelA)
//        history.levelI.append(stats.levelI)
//
//        history.averageE.append(stats.averageE)
//        history.averageD.append(stats.averageD)
//        history.averageA.append(stats.averageA)
//        history.averageI.append(stats.averageI)
//
//        history.volatilityE.append(stats.volatilityE)
//        history.volatilityD.append(stats.volatilityD)
//        history.volatilityA.append(stats.volatilityA)
//        history.volatilityI.append(stats.volatilityI)
//    }
//
//    return history
//}

/**
 Generate the complete history of mood levels, moving averages and moving volatilities from `data`.
 ??? UPDATE NAME - ELIMINATE OLD FUNCTION
 */
@inline(__always) func newGenerateHistory(data: DataStoreClass) async -> HistoryStruct {
    var history: HistoryStruct = HistoryStruct()
        
    // Mood levels
    for moodSnap in data.flattenedSequencedMoodSnaps {
        if moodSnap != nil {
            history.levelE.append(moodSnap!.elevation)
            history.levelD.append(moodSnap!.depression)
            history.levelA.append(moodSnap!.anxiety)
            history.levelI.append(moodSnap!.irritability)
        } else {
            history.levelE.append(nil)
            history.levelD.append(nil)
            history.levelA.append(nil)
            history.levelI.append(nil)
        }
    }
    
    // Moving averages
    for index in 0..<data.flattenedSequencedMoodSnaps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let moodSnaps: [MoodSnapStruct?] = Array(data.flattenedSequencedMoodSnaps[start...index])
        let averages: [CGFloat?] = average(moodSnaps: moodSnaps)
        
        history.averageE.append(averages[0])
        history.averageD.append(averages[1])
        history.averageA.append(averages[2])
        history.averageI.append(averages[3])
    }
    
    // Moving volatilities
    for index in 0..<data.sequencedMoodSnaps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let moodSnaps: [MoodSnapStruct?] = Array(data.sequencedMoodSnaps[start...index].joined())
        let volatilities = volatility(moodSnaps: moodSnaps)
        
        history.volatilityE.append(volatilities[0])
        history.volatilityD.append(volatilities[1])
        history.volatilityA.append(volatilities[2])
        history.volatilityI.append(volatilities[3])
    }
        
    return history
}
