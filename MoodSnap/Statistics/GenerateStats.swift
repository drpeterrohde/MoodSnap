import SwiftUI

/**
 Generate the complete history of mood levels, moving averages and moving volatilities from `data`.
 */
func generateHistory(data: DataStoreStruct) -> HistoryStruct {
    var date: Date = max(Date(), getLastDate(moodSnaps: data.moodSnaps))
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)
    var statsHistory: [StatsEntryStruct] = []

    while date >= earliest {
        var thisStats = StatsEntryStruct()

        let todaySnaps = getMoodSnapsByDate(moodSnaps: data.moodSnaps, date: date)
        let windowSnaps = getMoodSnapsByDateWindow(
            moodSnaps: data.moodSnaps,
            date: date,
            windowStart: -data.settings.slidingWindowSize + 1,
            windowEnd: 0,
            flatten: false)
        let mergedWindowSnaps = getMoodSnapsByDateWindow(
            moodSnaps: data.moodSnaps,
            date: date,
            windowStart: -data.settings.slidingWindowSize + 1,
            windowEnd: 0,
            flatten: true)

        if let todaySnap = mergeMoodSnaps(moodSnaps: todaySnaps) {
            thisStats.levelE = todaySnap.elevation
            thisStats.levelD = todaySnap.depression
            thisStats.levelA = todaySnap.anxiety
            thisStats.levelI = todaySnap.irritability
        }

        let thisAverages = average(moodSnaps: mergedWindowSnaps)
        thisStats.averageE = thisAverages[0]
        thisStats.averageD = thisAverages[1]
        thisStats.averageA = thisAverages[2]
        thisStats.averageI = thisAverages[3]

        let thisVolatilies = volatility(moodSnaps: windowSnaps)
        thisStats.volatilityE = thisVolatilies[0]
        thisStats.volatilityD = thisVolatilies[1]
        thisStats.volatilityA = thisVolatilies[2]
        thisStats.volatilityI = thisVolatilies[3]

        statsHistory.append(thisStats)
        date = date.addDays(days: -1)
    }

    statsHistory = statsHistory.reversed()

    var history = HistoryStruct()

    for stats in statsHistory {
        history.levelE.append(stats.levelE)
        history.levelD.append(stats.levelD)
        history.levelA.append(stats.levelA)
        history.levelI.append(stats.levelI)

        history.averageE.append(stats.averageE)
        history.averageD.append(stats.averageD)
        history.averageA.append(stats.averageA)
        history.averageI.append(stats.averageI)

        history.volatilityE.append(stats.volatilityE)
        history.volatilityD.append(stats.volatilityD)
        history.volatilityA.append(stats.volatilityA)
        history.volatilityI.append(stats.volatilityI)
    }

    return history
}
