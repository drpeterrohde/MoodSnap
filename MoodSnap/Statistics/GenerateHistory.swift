import SwiftUI

/**
 Sequence `moodSnaps` into chronological array.

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
@inline(__always) func generateHistory(data: DataStoreClass) async -> HistoryStruct {
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
