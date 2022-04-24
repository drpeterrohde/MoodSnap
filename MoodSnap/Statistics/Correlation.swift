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
        denominator += pow(reducedX[i]! - barX, 2)
    }

    if denominator == 0 {
        return nil
    }

    let slope = numerator / denominator

    return slope
}

/**
 Calculate the r2 for two series `dataX` and `dataY`, nil if no data.
 */
//func r2(dataX: [CGFloat?], dataY: [CGFloat?]) -> CGFloat? {
//    let (reducedX, reducedY) = reduceNils(dataX: dataX, dataY: dataY)
//
//    if reducedX.count == 0 || reducedY.count == 0 || reducedX.count != reducedY.count {
//        return nil
//    }
//
//    let barX: CGFloat = average(data: reducedX)!
//    let barY: CGFloat = average(data: reducedY)!
//    let barXX: CGFloat = average(dataX: reducedX, dataY: reducedX)!
//    let barYY: CGFloat = average(dataX: reducedY, dataY: reducedY)!
//    let barXY: CGFloat = average(dataX: reducedX, dataY: reducedY)!
//
//    var r2: CGFloat = 0
//
//    if barXY - barX * barY != 0 && ((barXX - barX * barX) * (barYY - barY * barY)) != 0 {
//        r2 = pow(barXY - barX * barY, 2) / ((barXX - barX * barX) * (barYY - barY * barY))
//    }
//
//    return r2
//}

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
//func getR2(data: DataStoreStruct, type: HealthTypeEnum) -> [CGFloat?] {
//    var samples: [CGFloat] = []
//    var elevationSamples: [CGFloat] = []
//    var depressionSamples: [CGFloat] = []
//    var anxietySamples: [CGFloat] = []
//    var irritabilitySamples: [CGFloat] = []
//
//    for healthSnap in data.healthSnaps {
//        let thisDate = healthSnap.timestamp
//        //   let moodSnaps = getMoodSnapsByDate(moodSnaps: data.moodSnaps, date: thisDate, flatten: true)
//        let moodSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps, date: thisDate, windowStart: 0, windowEnd: healthWindow, flatten: false)
//        let averageSnap = average(moodSnaps: moodSnaps)
//        let volatilitySnap = volatility(moodSnaps: moodSnaps)
//        if moodSnaps.count > 0 {
//            if type == .weight && healthSnap.weight != nil {
//                samples.append(healthSnap.weight!)
//                elevationSamples.append(averageSnap[0]!)
//                depressionSamples.append(averageSnap[1]!)
//                anxietySamples.append(averageSnap[2]!)
//                irritabilitySamples.append(averageSnap[3]!)
//            }
//            if type == .distance && healthSnap.walkingRunningDistance != nil {
//                samples.append(healthSnap.walkingRunningDistance!)
//                elevationSamples.append(averageSnap[0]!)
//                depressionSamples.append(averageSnap[1]!)
//                anxietySamples.append(averageSnap[2]!)
//                irritabilitySamples.append(averageSnap[3]!)
//            }
//        }
//    }
//
//    let elevationR2 = r2(dataX: samples, dataY: elevationSamples)
//    let depressionR2 = r2(dataX: samples, dataY: depressionSamples)
//    let anxietyR2 = r2(dataX: samples, dataY: anxietySamples)
//    let irritabilityR2 = r2(dataX: samples, dataY: irritabilitySamples)
//
//    return [elevationR2, depressionR2, anxietyR2, irritabilityR2]
//}

func getCorrelation(data: DataStoreStruct, health: HealthManager, type: HealthTypeEnum) -> [CGFloat?] {
    var samples: [CGFloat] = []
    var elevationSamples: [CGFloat] = []
    var depressionSamples: [CGFloat] = []
    var anxietySamples: [CGFloat] = []
    var irritabilitySamples: [CGFloat] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let healthSnaps = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        let moodSnaps = getMoodSnapsByDate(moodSnaps: data.moodSnaps, date: date, flatten: true)

        if healthSnaps.count != 0 && moodSnaps.count != 0 {
            switch type {
            case .weight:
                if healthSnaps[0].weight != nil {
                    samples.append(healthSnaps[0].weight!)
                    elevationSamples.append(moodSnaps[0].elevation)
                    depressionSamples.append(moodSnaps[0].depression)
                    anxietySamples.append(moodSnaps[0].anxiety)
                    irritabilitySamples.append(moodSnaps[0].irritability)
                }
            case .distance:
                if healthSnaps[0].walkingRunningDistance != nil {
                    samples.append(healthSnaps[0].walkingRunningDistance!)
                    elevationSamples.append(moodSnaps[0].elevation)
                    depressionSamples.append(moodSnaps[0].depression)
                    anxietySamples.append(moodSnaps[0].anxiety)
                    irritabilitySamples.append(moodSnaps[0].irritability)
                }
            default:
                break
            }
        }

        date = date.addDays(days: -1)
    }

    let elevationCorr = slope(dataX: samples, dataY: elevationSamples)
    let depressionCorr = slope(dataX: samples, dataY: depressionSamples)
    let anxietyCorr = slope(dataX: samples, dataY: anxietySamples)
    let irritabilityCorr = slope(dataX: samples, dataY: irritabilitySamples)

    return [elevationCorr, depressionCorr, anxietyCorr, irritabilityCorr]
}
