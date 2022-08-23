import SwiftUI

/**
 Calculate the volatility (standard deviation) of `data`, nil if no data.
 */
@inline(__always) func volatility(data: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0
    let average: CGFloat? = average(data: data)

    if average == nil {
        return nil
    }

    for value in data {
        if value != nil {
            sum += pow(value! - average!, 2.0)
            count += 1
        }
    }

    if count > 1 {
        return sqrt(sum / count)
    } else {
        return nil
    }
}

/**
 Calculate the volatiliy (standard deviation) of `moodSnaps`, nil if no data.
 */
@inline(__always) func volatility(moodSnaps: [MoodSnapStruct?]) -> [CGFloat?] {
    var dataE: [CGFloat] = []
    var dataD: [CGFloat] = []
    var dataA: [CGFloat] = []
    var dataI: [CGFloat] = []

    for moodSnap in moodSnaps {
        if moodSnap != nil {
            if moodSnap!.snapType == .mood {
                dataE.append(moodSnap!.elevation)
                dataD.append(moodSnap!.depression)
                dataA.append(moodSnap!.anxiety)
                dataI.append(moodSnap!.irritability)
            }
        }
    }

    let volatilityE = volatility(data: dataE)
    let volatilityD = volatility(data: dataD)
    let volatilityA = volatility(data: dataA)
    let volatilityI = volatility(data: dataI)

    return [volatilityE, volatilityD, volatilityA, volatilityI]
}
