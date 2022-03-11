import SwiftUI

func slidingAverage(data: [CGFloat?], windowSize: Int) -> [CGFloat?] {
    var avs: [CGFloat?] = []
    var thisAv: CGFloat?
    
    if (data.count > windowSize) {
        for offset in 0...(data.count-windowSize-1) {
            thisAv = average(data: Array(data[offset...(offset+windowSize-1)]))
            avs.append(thisAv)
        }
    } else {
        thisAv = average(data: data)
        avs.append(thisAv)
    }
    
    return avs
}
