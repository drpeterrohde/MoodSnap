import SwiftUI

/**
 Flatten `moodSnaps` on a per-day basis, pad missing dates with `nil`.
 */
//func flattenAndPad(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct?] {
//    var flattened: [MoodSnapStruct?] = []
//    let firstDate = getFirstDate(moodSnaps: moodSnaps).addDays(days: -1)
//    let lastDate = getLastDate(moodSnaps: moodSnaps)
//    var currentDate = firstDate
//
//    while (currentDate <= lastDate) {
//        let currentSnaps = getMoodSnapsByDate(moodSnaps: moodSnaps, date: currentDate)
//        let mergedSnap = mergeMoodSnaps(moodSnaps: currentSnaps)
//        flattened.append(mergedSnap)
//        currentDate = currentDate.addDays(days: 1)
//    }
//
//    return flattened
//}
