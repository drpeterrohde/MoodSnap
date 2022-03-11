import SwiftUI

func butterflyAverage(data: [CGFloat?], center: Int, maxWindowSize: Int) -> [CGFloat?]? {
    var avs: [CGFloat?] = []
    var leftCount: Int = 0
    var rightCount: Int = 0
    
    // Left
    for windowSize in stride(from: maxWindowSize, to: 2, by: -1) {
        let thisAv = average(data: Array(data[(center-windowSize+1)...center]))
        avs.append(thisAv)
        leftCount += 1
    }
    
    // Center
    avs.append(data[center])
    
    // Right
    for windowSize in stride(from: 2, to: maxWindowSize, by: 1) {
        let thisAv = average(data: Array(data[center...(center+windowSize-1)]))
        avs.append(thisAv)
        rightCount += 1
    }
    
    if (leftCount > 1 && rightCount > 1) {
        return avs
    } else {
        return nil
    }
}

