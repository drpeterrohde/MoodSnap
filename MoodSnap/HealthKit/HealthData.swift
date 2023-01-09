import SwiftUI

/**
 Return an array of all the weight data.
 */
@inline(__always) func getWeightData(moodSnaps: [MoodSnapStruct], healthSnaps: [HealthSnapStruct]) -> [CGFloat?] {
    var weightData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: moodSnaps).endOfDay()
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            weightData.append(thisHealthSnap[0].weight)
        }
        date = date.addDays(days: -1)
    }

    return weightData.reversed()
}

/**
 Return an array of all the sleep data.
 */
@inline(__always) func getSleepData(moodSnaps: [MoodSnapStruct], healthSnaps: [HealthSnapStruct]) -> [CGFloat?] {
    var sleepData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            sleepData.append(thisHealthSnap[0].sleepHours)
        }
        date = date.addDays(days: -1)
    }

    return sleepData.reversed()
}

/**
 Return an array of all the distance data.
 */
@inline(__always) func getDistanceData(moodSnaps: [MoodSnapStruct], healthSnaps: [HealthSnapStruct]) -> [CGFloat?] {
    var distanceData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            distanceData.append(thisHealthSnap[0].walkingRunningDistance)
        }
        date = date.addDays(days: -1)
    }

    return distanceData.reversed()
}

/**
 Return an array of all the distance data.
 */
@inline(__always) func getEnergyData(moodSnaps: [MoodSnapStruct], healthSnaps: [HealthSnapStruct]) -> [CGFloat?] {
    var energyData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            energyData.append(thisHealthSnap[0].activeEnergy)
        }
        date = date.addDays(days: -1)
    }

    return energyData.reversed()
}

/**
 Return an array of all the menstrual data.
 */
@inline(__always) func getMenstrualData(moodSnaps: [MoodSnapStruct], healthSnaps: [HealthSnapStruct]) -> [CGFloat?] {
    var menstrualData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            menstrualData.append(thisHealthSnap[0].menstrual)
        }
        date = date.addDays(days: -1)
    }

    return menstrualData.reversed()
}
