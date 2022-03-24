import SwiftUI

func slidingAverage(data: [CGFloat?], windowSize: Int) -> [CGFloat?] {
    var averages: [CGFloat?] = []
    
    if (data.count > windowSize) {
        for offset in 0...(data.count-windowSize-1) {
            let window = Array(data[offset...(offset+windowSize-1)])
            let thisAverage = average(data: window)
            averages.append(thisAverage)
        }
    } else {
        let thisAverage = average(data: data)
        averages.append(thisAverage)
    }
    
    return averages
}
