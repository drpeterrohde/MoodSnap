import SwiftUI

/**
 Linearly translate a series such that its midpoint is 0.
 */
func normSeries(series: [CGFloat?]) -> [CGFloat?] {
    let midValue: CGFloat? = series[(series.count - 1)/2]
    var normSeries: [CGFloat?] = []
    
    for index in 0 ..< series.count {
        if series[index] != nil && midValue != nil {
            normSeries.append(series[index]! - midValue!)
        } else {
            normSeries.append(nil)
        }
    }
    
    return normSeries
}

/**
 Average `ButterflyEntryStruct` from data centered around an array of `dates`.
 */
func averageButterflyForDates(dates: [Date], moodSnaps: [MoodSnapStruct], maxWindow: Int) -> ButterflyEntryStruct {
    let diffsMood = averageDifferentialWindowForDates(
        moodSnaps: moodSnaps,
        dates: dates,
        maxWindow: maxWindow)
    let diffsVolatility = volatilityDifferentialWindowForDates(
        moodSnaps: moodSnaps,
        dates: dates,
        maxWindow: maxWindow)

    var thisButterfly = ButterflyEntryStruct()
    
    thisButterfly.elevation = diffsMood[0]
    thisButterfly.depression = diffsMood[1]
    thisButterfly.anxiety = diffsMood[2]
    thisButterfly.irritability = diffsMood[3]

    thisButterfly.elevationVolatility = diffsVolatility[0]
    thisButterfly.depressionVolatility = diffsVolatility[1]
    thisButterfly.anxietyVolatility = diffsVolatility[2]
    thisButterfly.irritabilityVolatility = diffsVolatility[3]

    thisButterfly.occurrences = dates.count

    return thisButterfly
}
