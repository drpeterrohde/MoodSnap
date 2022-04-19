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
 
    var r2: CGFloat = 0
    
    if barXY - barX * barY != 0 && ((barXX - barX * barX) * (barYY - barY * barY)) != 0 {
        r2 = pow(barXY - barX * barY, 2) / ((barXX - barX * barX) * (barYY - barY * barY))
    }
    
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

/**
 Get R2 for weight versus mood levels
 */
func getR2(data: DataStoreStruct, type: HealthTypeEnum) -> [CGFloat?] {
    var samples: [CGFloat] = []
    var elevationSamples: [CGFloat] = []
    var depressionSamples: [CGFloat] = []
    var anxietySamples: [CGFloat] = []
    var irritabilitySamples: [CGFloat] = []

    for healthSnap in data.healthSnaps {
        let thisDate = healthSnap.timestamp
     //   let moodSnaps = getMoodSnapsByDate(moodSnaps: data.moodSnaps, date: thisDate, flatten: true)
        let moodSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps, date: thisDate, windowStart: 0, windowEnd: weightWindow, flatten: false)
        let averageSnap = average(moodSnaps: moodSnaps)
        let volatilitySnap = volatility(moodSnaps: moodSnaps)
        if moodSnaps.count > 0 {
            if healthSnap.weight != nil {
                switch type {
                case .weight:
                    samples.append(healthSnap.weight!)
                case .distance:
                    samples.append(healthSnap.walkingRunningDistance!)
                    
                }
                elevationSamples.append(averageSnap[0]!)
                depressionSamples.append(averageSnap[1]!)
                anxietySamples.append(averageSnap[2]!)
                irritabilitySamples.append(averageSnap[3]!)
            }
        }
    }

    let elevationR2 = r2(dataX: samples, dataY: elevationSamples)
    let depressionR2 = r2(dataX: samples, dataY: depressionSamples)
    let anxietyR2 = r2(dataX: samples, dataY: anxietySamples)
    let irritabilityR2 = r2(dataX: samples, dataY: irritabilitySamples)

    return [elevationR2, depressionR2, anxietyR2, irritabilityR2]
}
