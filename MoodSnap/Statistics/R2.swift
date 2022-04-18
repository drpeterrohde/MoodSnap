import SwiftUI

/**
 Calculate the r2 for two series `dataX` and `dataY`, nil if no data.
 */
func r2(dataX: [CGFloat?], dataY: [CGFloat?]) -> CGFloat? {
    let (reducedX, reducedY) = reduceNils(dataX: dataX, dataY: dataY)
    
    if reducedX.count == 0 || reducedY.count == 0 || reducedX.count != reducedY.count {
        return nil
    }
    
    let barX: CGFloat = average(data: reducedX)!
    let barY: CGFloat = average(data: reducedY)!
    let barXX: CGFloat = average(dataX: reducedX, dataY: reducedX)!
    let barYY: CGFloat = average(dataX: reducedY, dataY: reducedY)!
    let barXY: CGFloat = average(dataX: reducedX, dataY: reducedY)!
 
    let r2: CGFloat = pow(barXY - barX * barY, 2) / ((barXX - barX * barX) * (barYY - barY * barY))

    return r2
}

/**
 Eliminate nils from two sequences
 */
func reduceNils(dataX: [CGFloat?], dataY: [CGFloat?]) -> ([CGFloat?], [CGFloat?]) {
    var newDataX: [CGFloat?] = []
    var newDataY: [CGFloat?] = []

    if dataX.count == dataY.count {
        for i in 0 ..< dataX.count {
            if dataX[i] != nil && dataY[i] != nil {
                newDataX.append(dataX[i])
                newDataY.append(dataY[i])
            }
        }
    }

    return (newDataX, newDataY)
}

/**
 How many non-nil joint samples are there?
 */
func nonNilSamples(dataX: [CGFloat?], dataY: [CGFloat?]) -> Int {
    let (reducedX, _) = reduceNils(dataX: dataX, dataY: dataY)
    return reducedX.count
}
