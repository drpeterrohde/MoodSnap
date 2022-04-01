import SwiftUI

/**
 Count the total occurrences of symptoms and activites within the array of `butterflies`.
 */
func countAllOccurrences(butterflies: [ButterflyEntryStruct]) -> Int {
    var occurrences: Int = 0
    for butterfly in butterflies {
        occurrences += butterfly.occurrences
    }
    return occurrences
}

/**
 Count the total occurrences of symptoms, activites & social within the array `moodSnaps`.
 */
func countAllOccurrences(moodSnaps: [MoodSnapStruct], data: DataStoreStruct) -> ([Int], [Int], [Int]) {
    var symptomCount: [Int] = Array(repeating: 0, count: symptomList.count)
    var activityCount: [Int] = Array(repeating: 0, count: activityList.count)
    var socialCount: [Int] = Array(repeating: 0, count: socialList.count)
    
    for moodSnap in moodSnaps {
        for i in 0..<symptomList.count {
            if moodSnap.symptoms[i] && data.settings.symptomVisibility[i] {
                symptomCount[i] += 1
            }
        }
        
        for i in 0..<activityList.count {
            if moodSnap.activities[i] && data.settings.activityVisibility[i] {
                activityCount[i] += 1
            }
        }
        
        for i in 0..<socialList.count {
            if moodSnap.social[i] && data.settings.socialVisibility[i] {
                socialCount[i] += 1
            }
        }
    }
    
    return (symptomCount, activityCount, socialCount)
}
