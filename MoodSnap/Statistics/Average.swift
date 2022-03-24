import SwiftUI

/**
 Calculate the average of `data`, nil if no data.
 */
func average(data: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0
    
    for value in data {
        if (value != nil) {
            sum += value!
            count += 1
        }
    }
    
    if (count > 0) {
        return sum / count
    } else {
        return nil
    }
}

/**
 Calculate the mood averages of `moodSnaps`, nil if no data.
 */
func average(moodSnaps: [MoodSnapStruct]) -> [CGFloat?] {
    var dataE: [CGFloat] = []
    var dataD: [CGFloat] = []
    var dataA: [CGFloat] = []
    var dataI: [CGFloat] = []
    
    for moodSnap in moodSnaps {
        if (moodSnap.snapType == .mood) {
            dataE.append(moodSnap.elevation)
            dataD.append(moodSnap.depression)
            dataA.append(moodSnap.anxiety)
            dataI.append(moodSnap.irritability)
        }
    }
    
    let averageE = average(data: dataE)
    let averageD = average(data: dataD)
    let averageA = average(data: dataA)
    let averageI = average(data: dataI)
    
    return [averageE, averageD, averageA, averageI]
}
