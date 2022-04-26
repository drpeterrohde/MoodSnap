import SwiftUI

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
        var dayOffset: Int = 0
        
        if type == .sleep {
            dayOffset = 1
        }
        
        let healthSnaps = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        let moodSnaps = getMoodSnapsByDate(moodSnaps: data.moodSnaps, date: date.addDays(days: dayOffset), flatten: true)

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
            case .sleep:
                if healthSnaps[0].sleepHours != nil {
                    samples.append(healthSnaps[0].sleepHours!)
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
