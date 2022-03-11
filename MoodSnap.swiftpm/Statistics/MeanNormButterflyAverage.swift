import SwiftUI

func meanNormButterflyAverage(data: [[CGFloat?]], center: Int, maxWindowSize: Int) -> [CGFloat?] {
    var butterflies: [[CGFloat?]] = Array()
    let windowSize = data[0].count
    let numButterflies = data.count
    var meanZeroButterfly: [CGFloat?] = []
    
    // Generate individual mean-zero butterflies
    for thisData in data {
        let thisButterfly = normButterflyAverage(data: thisData, center: center, maxWindowSize: maxWindowSize)
        butterflies.append(thisButterfly)
    }
    
    // Element-wise average of mean-zero butterflies
    for i in 0...(windowSize-1) {
        var count: Int = 0
        var thisMean: CGFloat? = 0
        for j in 0...(numButterflies-1) {
            if (butterflies[j][i] != nil) {
                count += 1
                thisMean = thisMean! + butterflies[j][i]!
            }
        }
        if (count > 0) {
            thisMean = thisMean! / CGFloat(count)
        } else {
            thisMean = nil
        }
        meanZeroButterfly.append(thisMean)
    }
    
    return meanZeroButterfly
}
