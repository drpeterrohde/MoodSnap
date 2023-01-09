import SwiftUI

/**
 Sequence `moodSnaps` into chronological array.
 */
@inline(__always) func sequenceMoodSnaps(moodSnaps: [MoodSnapStruct]) -> [[MoodSnapStruct]] {
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)
    let length: Int = Calendar.current.numberOfDaysBetween(from: earliest, to: Date()) + 1
    var sequence: [[MoodSnapStruct]] = Array(repeating: [], count: length)
    
    for moodSnap in moodSnaps {
        if moodSnap.snapType == .mood {
            let offset = length - 1 - Calendar.current.numberOfDaysBetween(from: moodSnap.timestamp, to: Date())
            sequence[offset].append(moodSnap)
        }
    }
    
    return sequence
}

/**
 Flatten sequence of MoodSnaps on a per-day basis.
 */
@inline(__always) func flattenSequence(sequence: [[MoodSnapStruct]]) -> [MoodSnapStruct?] {
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
        
    let flattenedSequencedMoodSnaps = data.flattenedSequencedMoodSnaps
    let sequencedMoodSnaps = data.sequencedMoodSnaps
    
    // Mood levels
    for moodSnap in flattenedSequencedMoodSnaps {
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
    for index in 0..<flattenedSequencedMoodSnaps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let moodSnaps: [MoodSnapStruct?] = Array(flattenedSequencedMoodSnaps[start...index])
        let averages: [CGFloat?] = average(moodSnaps: moodSnaps)
        
        history.averageE.append(averages[0])
        history.averageD.append(averages[1])
        history.averageA.append(averages[2])
        history.averageI.append(averages[3])
    }
    
    // Moving volatilities
    for index in 0..<sequencedMoodSnaps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let moodSnaps: [MoodSnapStruct?] = Array(sequencedMoodSnaps[start...index].joined())
        let volatilities = volatility(moodSnaps: moodSnaps)
        
        history.volatilityE.append(volatilities[0])
        history.volatilityD.append(volatilities[1])
        history.volatilityA.append(volatilities[2])
        history.volatilityI.append(volatilities[3])
    }
        
    return history
}

/**
 Generate a binary timeline baed on a sequence of dates.
 `nil` where there is no `date`, `1` otherwise.
 */
@inline(__always) func generateTimelineForDates(moodSnaps: [MoodSnapStruct], dates: [Date]) -> [CGFloat?] {
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)
    let length: Int = Calendar.current.numberOfDaysBetween(from: earliest, to: Date()) + 1
    var timeline: [CGFloat?] = Array(repeating: nil, count: length)
    
    for date in dates {
        let offset = max(0, length - 1 - Calendar.current.numberOfDaysBetween(from: date, to: Date())) // hack
        timeline[offset] = 1
    }
    
    return timeline
}
