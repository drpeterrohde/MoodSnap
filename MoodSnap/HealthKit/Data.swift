import SwiftUI

/**
 Return an array of all the weight data.
 */
func getWeightData(data: DataStoreClass, health: HealthManager) -> [CGFloat?] {
    var weightData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps).endOfDay()
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
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
func getSleepData(data: DataStoreClass, health: HealthManager) -> [CGFloat?] {
    var sleepData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
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
func getDistanceData(data: DataStoreClass, health: HealthManager) -> [CGFloat?] {
    var distanceData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
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
func getEnergyData(data: DataStoreClass, health: HealthManager) -> [CGFloat?] {
    var energyData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
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
func getMenstrualData(data: DataStoreClass, health: HealthManager) -> [CGFloat?] {
    var menstrualData: [CGFloat?] = []

    var date: Date = getLastDate(moodSnaps: data.moodSnaps)
    let earliest: Date = getFirstDate(moodSnaps: data.moodSnaps)

    while date >= earliest {
        let thisHealthSnap = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        if thisHealthSnap.count > 0 {
            menstrualData.append(thisHealthSnap[0].menstrual)
        }
        date = date.addDays(days: -1)
    }

    return menstrualData.reversed()
}
