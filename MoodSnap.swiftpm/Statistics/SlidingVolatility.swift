import SwiftUI

func slidingVolatility(data: [CGFloat?], windowSize: Int) -> [CGFloat?] {
    var vols: [CGFloat?] = []
    var thisStdDev: CGFloat?
    
    if (data.count > windowSize) {
        for offset in 0...(data.count-windowSize-1) {
            thisStdDev = volatility(data: Array(data[offset...(offset+windowSize-1)]))
            vols.append(thisStdDev)
        }
    } else {
        thisStdDev = volatility(data: data)
        vols.append(thisStdDev)
    }
    
    return vols
}
