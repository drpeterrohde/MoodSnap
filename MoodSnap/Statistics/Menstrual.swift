import SwiftUI
import HealthKit

func filterMenstrualDates(dates: [Date], data: DataStoreStruct, health: HealthManager) -> [Date] {
    var date: Date = getFirstDate(moodSnaps: data.moodSnaps)
    let latest: Date = getLastDate(moodSnaps: data.moodSnaps)
    var dates: [Date] = []

    while date <= latest {
        let healthSnaps = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        if healthSnaps[0].menstrual != CGFloat(HKCategoryValueMenstrualFlow.none.rawValue) && healthSnaps[0].menstrual != CGFloat(
            HKCategoryValueMenstrualFlow.unspecified.rawValue) {
            dates.append(date)
            date = date.addDays(days: menstrualFilterJump)
            continue
        }
        date = date.addDays(days: 1)
    }
    
    return dates
}
