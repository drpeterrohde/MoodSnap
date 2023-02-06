import SwiftUI

/**
 Eliminate nils from two sequences
 */
@inline(__always) func reduceNils(dataX: [CGFloat?], dataY: [CGFloat?]) -> ([CGFloat?], [CGFloat?]) {
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
//@inline(__always) func nonNilSamples(dataX: [CGFloat?], dataY: [CGFloat?]) -> Int {
//    let (reducedX, _) = reduceNils(dataX: dataX, dataY: dataY)
//    return reducedX.count
//}
