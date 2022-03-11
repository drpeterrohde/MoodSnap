import SwiftUI

func blankInfluencesList() -> [InfluencesEntryStruct] {
    var entries: [InfluencesEntryStruct] = []
    var list = activityList + socialList
    for activity in list {
        var entry = InfluencesEntryStruct()
        entry.activity = activity
        entry.elevation = CGFloat.random(in: -2...2)
        entry.elevationVolatility = CGFloat.random(in: -2...2)
        entry.depression = nil
        entry.anxietyVolatility = nil
        entries.append(entry)
    }
    return entries
}

func influencePoint(data: [CGFloat?], center: Int, window: Int) -> CGFloat? {
    let lhs = average(data: Array(data[(center-window+1)...center]))
    let rhs = average(data: Array(data[center...(center+window-1)]))
    
    if (lhs != nil && rhs != nil) {
        return rhs!-lhs!
    } else {
        return nil
    }
}

func influenceAverage(data: [CGFloat?], centers: [Int], window: Int) -> (CGFloat?, Int) {
    var sum: CGFloat = 0
    var count: Int = 0
    
    for center in centers {
        let thisInfluence = influencePoint(data: data, center: center, window: window)
        if (thisInfluence != nil) {
            sum += thisInfluence!
            count += 1
        }
    }
    
    if (count > 0) {
        let average: CGFloat = sum/CGFloat(count)
        return (average, count)
    } else {
        return (nil, 0)
    }
}
