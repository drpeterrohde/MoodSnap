import SwiftUI

func averageByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int) -> [CGFloat?] {
    let samples = getMoodSnapsByDateWindow(
        moodSnaps: moodSnaps,
        date: date,
        windowStart: windowStart,
        windowEnd: windowEnd,
        flatten: true)
    let average = average(moodSnaps: samples)
    return average
}

func volatilityByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int) -> [CGFloat?] {
    let samples = getMoodSnapsByDateWindow(
        moodSnaps: moodSnaps,
        date: date,
        windowStart: windowStart,
        windowEnd: windowEnd,
        flatten: false)
    let volatility = volatility(moodSnaps: samples)
    return volatility
}

func averageDifferential(moodSnaps: [MoodSnapStruct], date: Date, window: Int) -> [CGFloat?] {
    let today = getMoodSnapsByDate(
        moodSnaps: moodSnaps, 
        date: date, 
        flatten: true)
    
    var samples: [MoodSnapStruct] = []
    if (window >= 0) {
        samples = getMoodSnapsByDateWindow(
            moodSnaps: moodSnaps, 
            date: date,
            windowStart: 0,
            windowEnd: window,
            flatten: true)
    } else {
        samples = getMoodSnapsByDateWindow(
            moodSnaps: moodSnaps,
            date: date,
            windowStart: window, 
            windowEnd: 0,
            flatten: true)
    }
    
    let todayAverage = average(moodSnaps: today)
    let windowAverage = average(moodSnaps: samples)
    
    var diffE: CGFloat? = nil
    var diffD: CGFloat? = nil
    var diffA: CGFloat? = nil
    var diffI: CGFloat? = nil
    
    if (todayAverage[0] != nil && windowAverage[0] != nil) {
        diffE = windowAverage[0]! - todayAverage[0]!
    }
    if (todayAverage[1] != nil && windowAverage[1] != nil) {
        diffD = windowAverage[1]! - todayAverage[1]!
    }
    if (todayAverage[2] != nil && windowAverage[2] != nil) {
        diffA = windowAverage[2]! - todayAverage[2]!
    }
    if (todayAverage[3] != nil && windowAverage[3] != nil) {
        diffI = windowAverage[3]! - todayAverage[3]!
    }
    
    return [diffE, diffD, diffA, diffI]
}

func volatilityDifferential(moodSnaps: [MoodSnapStruct], date: Date, window: Int) -> [CGFloat?] {
    var samples: [MoodSnapStruct] = []
    
    if (window >= 0) {
        samples = getMoodSnapsByDateWindow(
            moodSnaps: moodSnaps,
            date: date, 
            windowStart: 0, 
            windowEnd: window, 
            flatten: false)
    } else {
        samples = getMoodSnapsByDateWindow(
            moodSnaps: moodSnaps,
            date: date,
            windowStart: window, 
            windowEnd: 0, 
            flatten: false)
    }
    
    let windowVolatility = volatility(moodSnaps: samples)
    return windowVolatility
}

func averageDifferentialForDates(moodSnaps: [MoodSnapStruct], dates: [Date], window: Int) -> [CGFloat?] {
    var diffsE: [CGFloat?] = []
    var diffsD: [CGFloat?] = []
    var diffsA: [CGFloat?] = []
    var diffsI: [CGFloat?] = []
    
    for date in dates {
        let thisDiff = averageDifferential(
            moodSnaps: moodSnaps, 
            date: date,
            window: window)
        diffsE.append(thisDiff[0])
        diffsD.append(thisDiff[1])
        diffsA.append(thisDiff[2])
        diffsI.append(thisDiff[3])
    }
    
    let diffE = average(data: diffsE)
    let diffD = average(data: diffsD)
    let diffA = average(data: diffsA)
    let diffI = average(data: diffsI)
    
    return [diffE, diffD, diffA, diffI]
}

func volatilityDifferentialForDates(moodSnaps: [MoodSnapStruct], dates: [Date], window: Int) -> [CGFloat?] {
    var diffsE: [CGFloat?] = []
    var diffsD: [CGFloat?] = []
    var diffsA: [CGFloat?] = []
    var diffsI: [CGFloat?] = []
    
    for date in dates {
        let thisDiff = volatilityDifferential(
            moodSnaps: moodSnaps,
            date: date, 
            window: window)
        diffsE.append(thisDiff[0])
        diffsD.append(thisDiff[1])
        diffsA.append(thisDiff[2])
        diffsI.append(thisDiff[3])
    }
    
    let diffE = average(data: diffsE)
    let diffD = average(data: diffsE)
    let diffA = average(data: diffsE)
    let diffI = average(data: diffsE)
    
    return [diffE, diffD, diffA, diffI]
}

func averageDifferentialWindowForDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> [[CGFloat?]] {
    var diffsE: [[CGFloat?]] = []
    var diffsD: [[CGFloat?]] = []
    var diffsA: [[CGFloat?]] = []
    var diffsI: [[CGFloat?]] = []
    
    for date in dates {
        let thisDiff = averageDifferentialWindow(
            moodSnaps: moodSnaps,
            date: date,
            maxWindow: maxWindow)
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

func volatilityDifferentialWindowForDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> [[CGFloat?]] {
    var diffsE: [[CGFloat?]] = []
    var diffsD: [[CGFloat?]] = []
    var diffsA: [[CGFloat?]] = []
    var diffsI: [[CGFloat?]] = []
    
    for date in dates {
        let thisDiff = volatilityDifferentialWindow(
            moodSnaps: moodSnaps,
            date: date,
            maxWindow: maxWindow)
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

func averageDifferentialWindow(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> [[CGFloat?]] {
    var seriesE: [CGFloat?] = []
    var seriesD: [CGFloat?] = []
    var seriesA: [CGFloat?] = []
    var seriesI: [CGFloat?] = []
    
    for window in -maxWindow...maxWindow {
        let thisDiff: [CGFloat?] = averageDifferential(
            moodSnaps: moodSnaps,
            date: date, 
            window: window)
        seriesE.append(thisDiff[0])
        seriesD.append(thisDiff[1])
        seriesA.append(thisDiff[2])
        seriesI.append(thisDiff[3])
    }
    
    return [seriesE, seriesD, seriesA, seriesI]
}

func volatilityDifferentialWindow(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> [[CGFloat?]] {
    var seriesE: [CGFloat?] = []
    var seriesD: [CGFloat?] = []
    var seriesA: [CGFloat?] = []
    var seriesI: [CGFloat?] = []
    
    for window in -maxWindow...maxWindow {
        let thisDiff: [CGFloat?] = volatilityDifferential(
            moodSnaps: moodSnaps, 
            date: date, 
            window: window)
        seriesE.append(thisDiff[0])
        seriesD.append(thisDiff[1])
        seriesA.append(thisDiff[2])
        seriesI.append(thisDiff[3])
    }
    
    return [seriesE, seriesD, seriesA, seriesI]
}

func averageSeries(series: [[CGFloat?]]) -> [CGFloat?] {
    if series.count == 0 {
        return []
    }
    
    var newSeries: [CGFloat?] = []
    
    for index in 0..<series[0].count {
        var theseVals: [CGFloat?] = []
        for whichSeries in series {
            theseVals.append(whichSeries[index])
        }
        let thisAverage = average(data: theseVals)
        newSeries.append(thisAverage)
    }
    
    return newSeries
}

func getDatesForHashtag(hashtag: String, moodSnaps: [MoodSnapStruct]) -> [Date] {
    var dates: [Date] = []
    for moodSnap in moodSnaps {
        if moodSnap.notes.lowercased().contains(hashtag) || moodSnap.event.lowercased().contains(hashtag) {
            dates.append(moodSnap.timestamp)
        }
    }
    return dates
}

func getDatesForType(type: InfluenceTypeEnum, item: Int, moodSnaps: [MoodSnapStruct]) -> [Date] {
    var dates: [Date] = []
    
    if type == .event {
        let event = getEventsList(moodSnaps: moodSnaps)[item]
        dates.append(event.1)
        return dates
    }
    
    for moodSnap in moodSnaps {
        switch type {
        case .activity:
            if moodSnap.activities[activityListIndex[item]] {
                dates.append(moodSnap.timestamp)
            }
        case .social:
            if moodSnap.social[socialListIndex[item]] {
                dates.append(moodSnap.timestamp)
            }
        case .symptom:
            if moodSnap.symptoms[symptomListIndex[item]] {
                dates.append(moodSnap.timestamp)
            }
        default:
            break
        }
    }
    
    return dates
}
