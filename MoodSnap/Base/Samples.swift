import SwiftUI

/**
 Return all mood samples from array of `moodSnaps`.
 */
func getAllSamples(moodSnaps: [MoodSnapStruct?]) -> [[CGFloat?]] {
    var samplesE: [CGFloat?] = []
    var samplesD: [CGFloat?] = []
    var samplesA: [CGFloat?] = []
    var samplesI: [CGFloat?] = []
    
    for moodSnap in moodSnaps {
        if moodSnap == nil {
            samplesE.append(nil)
            samplesD.append(nil)
            samplesA.append(nil)
            samplesI.append(nil)
        } else {
            samplesE.append(moodSnap!.elevation)
            samplesD.append(moodSnap!.depression)
            samplesA.append(moodSnap!.anxiety)
            samplesI.append(moodSnap!.irritability)
        }
    }
    
    return [samplesE, samplesD, samplesA, samplesI]
}

/**
 Return all mood samples from array of `moodSnaps`, padded with `nil` for missing dates.
 */
func getFlattenedPaddedSamples(moodSnaps: [MoodSnapStruct]) -> [[CGFloat?]] {
    let flattenedMoodSnaps = flattenAndPadMoodSnaps(moodSnaps: moodSnaps)
    return getAllSamples(moodSnaps: flattenedMoodSnaps)
}

/**
 Flatten `moodSnaps` on a per-day basis, pad missing dates with `nil`.
 */
func flattenAndPadMoodSnaps(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct?] {
    var flattened: [MoodSnapStruct?] = []
    let firstDate = getFirstDate(moodSnaps: moodSnaps).addDays(days: -1)
    let lastDate = getLastDate(moodSnaps: moodSnaps).addDays(days: 1)
    var currentDate = firstDate
    
    while (currentDate <= lastDate) {
        let currentSnaps = getMoodSnapsByDate(moodSnaps: moodSnaps, date: currentDate)
        if let mergedSnap = mergeMoodSnaps(moodSnaps: currentSnaps) {
            flattened.append(mergedSnap)
        } else {
            flattened.append(nil)
        }
        currentDate = currentDate.addDays(days: 1) //Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return flattened
}

///**
// Get flattened MoodSnaps by `date`.
// */
//func getMergedSampleByDate(moodSnaps: [MoodSnapStruct], date: Date) -> [CGFloat?] {
//    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
//    var moodSnapsByDate: [MoodSnapStruct] = []
//    
//    for moodSnap in moodSnaps {
//        if (moodSnap.snapType == .mood) {
//            let thisDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: moodSnap.timestamp)
//            
//            if (dateComponents == thisDateComponents) {
//                moodSnapsByDate.append(moodSnap)
//            }
//        }
//    }
//    
//    var sampleE: CGFloat? = nil
//    var sampleD: CGFloat? = nil
//    var sampleA: CGFloat? = nil
//    var sampleI: CGFloat? = nil
//    
//    if let mergedMoodSnap = mergeMoodSnaps(moodSnaps: moodSnapsByDate) {
//        sampleE = mergedMoodSnap.elevation
//        sampleD = mergedMoodSnap.depression
//        sampleA = mergedMoodSnap.anxiety
//        sampleI = mergedMoodSnap.irritability
//    }
//    
//    return [sampleE, sampleD, sampleA, sampleI]
//}

///**
// Get mood samples of a given mood `type` within a date window.
// */
//func getSamplesByDateWindow(moodSnaps: [MoodSnapStruct], endDate: Date, windowInterval: Int, type: MoodsEnum) -> [CGFloat?] {
//    let endDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: endDate)
//    let startDate = subtractDaysFromDate(date: endDate, days: windowInterval-1)!
//    let startDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: startDate)
//    
//    var samples: [CGFloat] = []
//    
//    for moodSnap in moodSnaps {
//        if (moodSnap.snapType == .mood) {
//            let thisDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: moodSnap.timestamp)
//            
//            if (thisDateComponents >= startDateComponents && thisDateComponents <= endDateComponents) {
//                switch type {
//                case .elevation:
//                    samples.append(moodSnap.elevation)
//                case .depression:
//                    samples.append(moodSnap.depression)
//                case .anxiety:
//                    samples.append(moodSnap.anxiety)
//                case .irritability:
//                    samples.append(moodSnap.irritability)
//                }
//            }
//        }
//    }
//    
//    return samples
//}
