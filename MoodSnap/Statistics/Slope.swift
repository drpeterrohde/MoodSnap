import SwiftUI

/**
 Calculate the slope of the line of best fit from `dataX` and `dataY`.
 */
func slope(dataX: [CGFloat?], dataY: [CGFloat?]) -> CGFloat? {
    let (reducedX, reducedY) = reduceNils(dataX: dataX, dataY: dataY)

    if reducedX.count == 0 || reducedY.count == 0 || reducedX.count != reducedY.count {
        return nil
    }

    let barX: CGFloat = average(data: reducedX)!
    let barY: CGFloat = average(data: reducedY)!

    var numerator: CGFloat = 0
    var denominator: CGFloat = 0

    for i in 0 ..< reducedX.count {
        numerator += (reducedX[i]! - barX) * (reducedY[i]! - barY)
        denominator += (reducedX[i]! - barX) * (reducedX[i]! - barX)
    }

    if denominator == 0 {
        return nil
    }

    let slope = numerator / denominator

    return slope
}
