import SwiftUI

/**
 Get the trend for moving `averages`.
 */
func getTrend(averages: [CGFloat?]) -> String {
    let last = averages.count - 1
    
    if last < 7 {
        return "-"
    }
    
    if averages[last] != nil && averages[last-7] != nil {
        let diff = averages[last]! - averages[last-7]!
        let diffString = formatMoodLevelString(value: diff)
        return diffString
    }
    
    return "-"
}
