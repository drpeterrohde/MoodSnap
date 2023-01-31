import SwiftUI

/**
 Average `ButterflyEntryStruct` from data centered around an array of `dates`.
 */
@inline(__always) func averageTransientForDates(dates: [Date], data: DataStoreClass, maxWindow: Int) -> ButterflyEntryStruct {
    let moodSnaps = data.moodSnaps
    let butterflyMood = averageDifferentialWindowForDates(moodSnaps: moodSnaps, dates: dates, maxWindow: maxWindow)
    let butterflyVolatility = volatilityDifferentialWindowForDates(moodSnaps: moodSnaps, dates: dates, maxWindow: maxWindow)
    
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
    thisButterfly.timeline = generateTimelineForDates(moodSnaps: moodSnaps, dates: dates)
    thisButterfly.deltas = deltaOccurences(data: data, dates: dates, maxWindow: maxWindow)
    
    return thisButterfly
}

/**
 Differential (average) foccused on `date`.
 */
@inline(__always) func averageDifferential(moodSnaps: [MoodSnapStruct], date: Date, window: Int) -> [CGFloat?] {
    var today: [MoodSnapStruct] = getMoodSnapsByDate(moodSnaps: moodSnaps, date: date, flatten: true)
    
    let todayCount = today.count
    
    var todaySnap = MoodSnapStruct()
    if todayCount == 0 {
        todaySnap.timestamp = date
        today = [todaySnap]
    }

    var samples: [MoodSnapStruct] = []
    
    if window >= 0 {
        samples = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: 0, windowEnd: window, flatten: true)
    } else {
        samples = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: window, windowEnd: 0, flatten: true)
    }
    
    if todayCount == 0 {
        samples.append(todaySnap)
    }

    let todayAverage = average(moodSnaps: today)
    let windowAverage = average(moodSnaps: samples)

    var diffE: CGFloat?
    var diffD: CGFloat?
    var diffA: CGFloat?
    var diffI: CGFloat?

    if todayAverage[0] != nil && windowAverage[0] != nil {
        diffE = windowAverage[0]! - todayAverage[0]!
    }
    if todayAverage[1] != nil && windowAverage[1] != nil {
        diffD = windowAverage[1]! - todayAverage[1]!
    }
    if todayAverage[2] != nil && windowAverage[2] != nil {
        diffA = windowAverage[2]! - todayAverage[2]!
    }
    if todayAverage[3] != nil && windowAverage[3] != nil {
        diffI = windowAverage[3]! - todayAverage[3]!
    }

    return [diffE, diffD, diffA, diffI]
}

/**
 Differential (volatility) foccused on `date`.
 */
@inline(__always) func volatilityDifferential(moodSnaps: [MoodSnapStruct], date: Date, window: Int) -> [CGFloat?] {
    var samples: [MoodSnapStruct] = []

    if window >= 0 {
        samples = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: 0, windowEnd: window, flatten: false)
    } else {
        samples = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: window, windowEnd: 0, flatten: false)
    }

    return volatility(moodSnaps: samples)
}

/**
 Differential (average) foccused on `dates` array.
 */
@inline(__always) func averageDifferentialWindowForDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> [[CGFloat?]] {
    var diffsE: [[CGFloat?]] = []
    var diffsD: [[CGFloat?]] = []
    var diffsA: [[CGFloat?]] = []
    var diffsI: [[CGFloat?]] = []

    for date in dates {
        let thisDiff = averageDifferentialWindow(moodSnaps: moodSnaps, date: date, maxWindow: maxWindow)
        diffsE.append(thisDiff[0])
        diffsD.append(thisDiff[1])
        diffsA.append(thisDiff[2])
        diffsI.append(thisDiff[3])
    }

    let diffE = averageSeries(series: diffsE)
    let diffD = averageSeries(series: diffsD)
    let diffA = averageSeries(series: diffsA)
    let diffI = averageSeries(series: diffsI)

    return [diffE, diffD, diffA, diffI]
}

/**
 Differential (volatility) foccused on `dates` array.
 */
@inline(__always) func volatilityDifferentialWindowForDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> [[CGFloat?]] {
    var diffsE: [[CGFloat?]] = []
    var diffsD: [[CGFloat?]] = []
    var diffsA: [[CGFloat?]] = []
    var diffsI: [[CGFloat?]] = []

    for date in dates {
        let thisDiff = volatilityDifferentialWindow(moodSnaps: moodSnaps, date: date, maxWindow: maxWindow)
        diffsE.append(thisDiff[0])
        diffsD.append(thisDiff[1])
        diffsA.append(thisDiff[2])
        diffsI.append(thisDiff[3])
    }

    let diffE = averageSeries(series: diffsE)
    let diffD = averageSeries(series: diffsD)
    let diffA = averageSeries(series: diffsA)
    let diffI = averageSeries(series: diffsI)

    return [diffE, diffD, diffA, diffI]
}

/**
 Differential (average) foccused on `date` over a `maxWindow`.
 */
@inline(__always) func averageDifferentialWindow(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> [[CGFloat?]] {
    var seriesE: [CGFloat?] = []
    var seriesD: [CGFloat?] = []
    var seriesA: [CGFloat?] = []
    var seriesI: [CGFloat?] = []
    
    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: -maxWindow, windowEnd: maxWindow)

    for window in -maxWindow ... maxWindow {
        let thisDiff: [CGFloat?] = averageDifferential(moodSnaps: windowSnaps, date: date, window: window)
        seriesE.append(thisDiff[0])
        seriesD.append(thisDiff[1])
        seriesA.append(thisDiff[2])
        seriesI.append(thisDiff[3])
    }

    return [seriesE, seriesD, seriesA, seriesI]
}

/**
 Calculate the occurences of symptoms and activites relative to a `date` with given `maxWindow`.
 */
@inline(__always) func deltaOccurences(data: DataStoreClass, date: Date, maxWindow: Int) -> OccurencesStruct {
    let beforeMoodSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps, date: date, windowStart: -maxWindow, windowEnd: 0)
    let afterMoodSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps, date: date, windowStart: 0, windowEnd: maxWindow)
    
    let beforeOccurences = countAllOccurrences(moodSnaps: beforeMoodSnaps, settings: data.settings)
    let afterOccurences = countAllOccurrences(moodSnaps: afterMoodSnaps, settings: data.settings)
    let deltaOccurences = (zip(afterOccurences.0, beforeOccurences.0).map(-),
                           zip(afterOccurences.1, beforeOccurences.1).map(-),
                           zip(afterOccurences.2, beforeOccurences.2).map(-))
    let beforeHashtags = countHashtagOccurrences(hashtags: data.hashtagList, moodSnaps: beforeMoodSnaps)
    let afterHashtags = countHashtagOccurrences(hashtags: data.hashtagList, moodSnaps: afterMoodSnaps)
    let deltaHashtags = zip(afterHashtags, beforeHashtags).map(-)

    var occurences = OccurencesStruct()
    
    occurences.beforeSymptoms = beforeOccurences.0.map { Double($0) }
    occurences.beforeActivities = beforeOccurences.1.map { Double($0) }
    occurences.beforeSocial = beforeOccurences.2.map { Double($0) }
    occurences.beforeHashtags = beforeHashtags.map { Double($0) }

    occurences.afterSymptoms = afterOccurences.0.map { Double($0) }
    occurences.afterActivities = afterOccurences.1.map { Double($0) }
    occurences.afterSocial = afterOccurences.2.map { Double($0) }
    occurences.afterHashtags = afterHashtags.map { Double($0) }
    
    occurences.deltaSymptoms = deltaOccurences.0.map { Double($0) }
    occurences.deltaActivities = deltaOccurences.1.map { Double($0) }
    occurences.deltaSocial = deltaOccurences.2.map { Double($0) }
    occurences.deltaHashtags = deltaHashtags.map { Double($0) }
    
    return occurences
}

/**
 Calculate the occurences of symptoms and activites relative to `dates` with given `maxWindow`.
 */
@inline(__always) func deltaOccurences(data: DataStoreClass, dates: [Date], maxWindow: Int) -> OccurencesStruct {
    var deltas: [OccurencesStruct] = []
    let endDate: Date = getLastDate(moodSnaps: data.moodSnaps).endOfDay()
    let startDate: Date = getFirstDate(moodSnaps: data.moodSnaps)
    
    for date in dates {
        let bufferStart = abs(Calendar.current.numberOfDaysBetween(from: startDate, to: date))
        let bufferEnd = abs(Calendar.current.numberOfDaysBetween(from: date, to: endDate))
        
        if bufferStart >= maxWindow && bufferEnd >= maxWindow {
            let thisDelta = deltaOccurences(data: data, date: date, maxWindow: maxWindow)
            deltas.append(thisDelta)
        }
    }
    
    return averageDelta(deltas: deltas)
}

/**
 Calculate the average `OccurenceStruct` from an array of `[OccurenceStruct]`s.
 */
@inline(__always) func averageDelta(deltas: [OccurencesStruct]) -> OccurencesStruct {
    if deltas.count == 0 {
        return OccurencesStruct()
    } else {
        var average: OccurencesStruct = deltas[0]
        
        for i in 1 ..< deltas.count {
            average.beforeActivities = zip(average.beforeActivities, deltas[i].beforeActivities).map(+)
            average.beforeSymptoms = zip(average.beforeSymptoms, deltas[i].beforeSymptoms).map(+)
            average.beforeSocial = zip(average.beforeSocial, deltas[i].beforeSocial).map(+)
            average.beforeHashtags = zip(average.beforeHashtags, deltas[i].beforeHashtags).map(+)
            
            average.afterActivities = zip(average.afterActivities, deltas[i].afterActivities).map(+)
            average.afterSymptoms = zip(average.afterSymptoms, deltas[i].afterSymptoms).map(+)
            average.afterSocial = zip(average.afterSocial, deltas[i].afterSocial).map(+)
            average.afterHashtags = zip(average.afterHashtags, deltas[i].afterHashtags).map(+)
            
            average.deltaActivities = zip(average.deltaActivities, deltas[i].deltaActivities).map(+)
            average.deltaSymptoms = zip(average.deltaSymptoms, deltas[i].deltaSymptoms).map(+)
            average.deltaSocial = zip(average.deltaSocial, deltas[i].deltaSocial).map(+)
            average.deltaHashtags = zip(average.deltaHashtags, deltas[i].deltaHashtags).map(+)
        }
        
        average.beforeActivities = average.beforeActivities.map {Double($0) / Double(deltas.count)}
        average.beforeSymptoms = average.beforeSymptoms.map {Double($0) / Double(deltas.count)}
        average.beforeSocial = average.beforeSocial.map {Double($0) / Double(deltas.count)}
        average.beforeHashtags = average.beforeHashtags.map {Double($0) / Double(deltas.count)}
        
        average.afterActivities = average.afterActivities.map {Double($0) / Double(deltas.count)}
        average.afterSymptoms = average.afterSymptoms.map {Double($0) / Double(deltas.count)}
        average.afterSocial = average.afterSocial.map {Double($0) / Double(deltas.count)}
        average.afterHashtags = average.afterHashtags.map {Double($0) / Double(deltas.count)}
        
        average.deltaActivities = average.deltaActivities.map {Double($0) / Double(deltas.count)}
        average.deltaSymptoms = average.deltaSymptoms.map {Double($0) / Double(deltas.count)}
        average.deltaSocial = average.deltaSocial.map {Double($0) / Double(deltas.count)}
        average.deltaHashtags = average.deltaHashtags.map {Double($0) / Double(deltas.count)}
        
        return average
    }
}

/**
 Differential (volatility) foccused on `date` over a `maxWindow`.
 */
@inline(__always) func volatilityDifferentialWindow(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> [[CGFloat?]] {
    var seriesE: [CGFloat?] = []
    var seriesD: [CGFloat?] = []
    var seriesA: [CGFloat?] = []
    var seriesI: [CGFloat?] = []

    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: date, windowStart: -maxWindow, windowEnd: maxWindow)
    
    for window in -maxWindow ... maxWindow {
        if window == -maxWindow || window == maxWindow {
            let thisDiff: [CGFloat?] = volatilityDifferential(
                moodSnaps: windowSnaps,
                date: date,
                window: window)
            seriesE.append(thisDiff[0])
            seriesD.append(thisDiff[1])
            seriesA.append(thisDiff[2])
            seriesI.append(thisDiff[3])
        } else {
            seriesE.append(nil)
            seriesD.append(nil)
            seriesA.append(nil)
            seriesI.append(nil)
        }
    }

    return [seriesE, seriesD, seriesA, seriesI]
}

/**
 Dispatch transient calculation depending on `type`.
 */
@inline(__always) func transientByType(type: InfluenceTypeEnum, activity: Int, social: Int, symptom: Int, event: Int, hashtag: Int, processedData: ProcessedDataStruct) -> ButterflyEntryStruct {
    switch type {
    case .activity:
        return processedData.activityButterfly[activity]
    case .social:
        return processedData.socialButterfly[social]
    case .symptom:
        return processedData.symptomButterfly[symptom]
    case .event:
        return processedData.eventButterfly[event]
    case .hashtag:
        return processedData.hashtagButterfly[hashtag]
    }
}
