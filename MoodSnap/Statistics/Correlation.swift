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
 Get `health` correlations for a given health `type`.
 */
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
            case .energy:
                if healthSnaps[0].activeEnergy != nil {
                    samples.append(healthSnaps[0].activeEnergy!)
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