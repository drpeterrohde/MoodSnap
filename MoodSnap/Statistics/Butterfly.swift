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

func averageButterfly(series: [[CGFloat?]]) -> [CGFloat?] {
    var norms: [[CGFloat?]] = []
    
    for item in series {
        let norm = normSeries(series: item)
        norms.append(norm)
    }
    
    let butterfly = averageSeries(series: norms)
    return butterfly
}

func averageButterfly(butterflies: [ButterflyEntryStruct]) -> ButterflyEntryStruct? {
    if butterflies.count == 0 {
        return nil
    }
    
    var averageButterfly = ButterflyEntryStruct()
    averageButterfly.activity = butterflies[0].activity
    averageButterfly.timestamp = butterflies[0].timestamp
    
    var elevation: [[CGFloat?]] = []
    var depression: [[CGFloat?]] = []
    var anxiety: [[CGFloat?]] = []
    var irritability: [[CGFloat?]] = []
    
    var elevationVolatility: [[CGFloat?]] = []
    var depressionVolatility: [[CGFloat?]] = []
    var anxietyVolatility: [[CGFloat?]] = []
    var irritabilityVolatility: [[CGFloat?]] = []
    
    for butterfly in butterflies {
        elevation.append(butterfly.elevation)
        depression.append(butterfly.depression)
        anxiety.append(butterfly.anxiety)
        irritability.append(butterfly.irritability)
        
        elevationVolatility.append(butterfly.elevationVolatility)
        depressionVolatility.append(butterfly.depressionVolatility)
        anxietyVolatility.append(butterfly.anxietyVolatility)
        irritabilityVolatility.append(butterfly.irritabilityVolatility)
    }
    
    averageButterfly.elevation = averageSeries(series: elevation)
    averageButterfly.depression = averageSeries(series: depression)
    averageButterfly.anxiety = averageSeries(series: anxiety)
    averageButterfly.irritability = averageSeries(series: irritability)
    
    averageButterfly.elevationVolatility = averageSeries(series: elevationVolatility)
    averageButterfly.depressionVolatility = averageSeries(series: depressionVolatility)
    averageButterfly.anxietyVolatility = averageSeries(series: anxietyVolatility)
    averageButterfly.irritabilityVolatility = averageSeries(series: irritabilityVolatility)
    
    return averageButterfly
}

/**
 Return butterfly for a `date`.
 */
//func butterflyByDate(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> ButterflyEntryStruct {
//    var butterfly = ButterflyEntryStruct()
//    
//    // Past
//    for window in -(maxWindow-1) ... -1 {
//        let thisAverage = averageByDateWindow(
//            moodSnaps: moodSnaps, 
//            date: date,
//            windowStart: window, 
//            windowEnd: 0)
//        butterfly.elevation.append(thisAverage[0])
//        butterfly.depression.append(thisAverage[1])
//        butterfly.anxiety.append(thisAverage[2])
//        butterfly.irritability.append(thisAverage[3])
//        
//        let thisVolatility = volatilityByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date, 
//            windowStart: window, 
//            windowEnd: 0)
//        butterfly.elevationVolatility.append(thisVolatility[0])
//        butterfly.depressionVolatility.append(thisVolatility[1])
//        butterfly.anxietyVolatility.append(thisVolatility[2])
//        butterfly.irritabilityVolatility.append(thisVolatility[3])
//    }
//    
//    // Present
//    let thisAverage = averageByDateWindow(
//        moodSnaps: moodSnaps,
//        date: date, 
//        windowStart: 0, 
//        windowEnd: 0)
//    butterfly.elevation.append(thisAverage[0])
//    butterfly.depression.append(thisAverage[1])
//    butterfly.anxiety.append(thisAverage[2])
//    butterfly.irritability.append(thisAverage[3])
//    
//    butterfly.elevationVolatility.append(nil)
//    butterfly.depressionVolatility.append(nil)
//    butterfly.anxietyVolatility.append(nil)
//    butterfly.irritabilityVolatility.append(nil)
//    
//    // Future
//    for window in 1 ... (maxWindow-1) {
//        let thisAverage = averageByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date, 
//            windowStart: 0, 
//            windowEnd: window)
//        
//        butterfly.elevation.append(thisAverage[0])
//        butterfly.depression.append(thisAverage[1])
//        butterfly.anxiety.append(thisAverage[2])
//        butterfly.irritability.append(thisAverage[3])
//        
//        let thisVolatility = volatilityByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date,
//            windowStart: 0, 
//            windowEnd: window)
//        butterfly.elevationVolatility.append(thisVolatility[0])
//        butterfly.depressionVolatility.append(thisVolatility[1])
//        butterfly.anxietyVolatility.append(thisVolatility[2])
//        butterfly.irritabilityVolatility.append(thisVolatility[3])
//    }
//    
//    return butterfly
//}

//func averageButterflyByDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> ButterflyEntryStruct? {
//    var butterflies: [ButterflyEntryStruct] = []
//    
//    for date in dates {
//        let thisButterfly: ButterflyEntryStruct = butterflyByDate(
//            moodSnaps: moodSnaps,
//            date: date,
//            maxWindow: maxWindow)
//        butterflies.append(thisButterfly)
//    }
//    
//    let butterfly = averageButterfly(butterflies: butterflies)
//    return butterfly
//}

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
