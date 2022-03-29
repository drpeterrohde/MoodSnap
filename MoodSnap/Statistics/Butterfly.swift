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
    let butterflyMood = averageDifferentialWindowForDates(
        moodSnaps: moodSnaps,
        dates: dates,
        maxWindow: maxWindow)
    let butterflyVolatility = volatilityDifferentialWindowForDates(
        moodSnaps: moodSnaps,
        dates: dates,
        maxWindow: maxWindow)

    var thisButterfly = ButterflyEntryStruct()
    
    thisButterfly.elevation = butterflyMood[0]
    thisButterfly.depression = butterflyMood[1]
    thisButterfly.anxiety = butterflyMood[2]
    thisButterfly.irritability = butterflyMood[3]

    thisButterfly.elevationVolatility = butterflyVolatility[0]
    thisButterfly.depressionVolatility = butterflyVolatility[1]
    thisButterfly.anxietyVolatility = butterflyVolatility[2]
    thisButterfly.irritabilityVolatility = butterflyVolatility[3]

    thisButterfly.occurrences = dates.count

    return thisButterfly
}
