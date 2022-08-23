import HealthKit
import SwiftUI

/**
 Filter mestrual dates to jump consective `dates`.
 */
@inline(__always) func filterMenstrualDates(dates: [Date], data: DataStoreClass, health: HealthManager) -> [Date] {
    var date: Date = getFirstDate(moodSnaps: data.moodSnaps)
    let latest: Date = getLastDate(moodSnaps: data.moodSnaps)
    var dates: [Date] = []

    while date <= latest {
        let healthSnaps = getHealthSnapsByDate(healthSnaps: health.healthSnaps, date: date, flatten: true)
        if healthSnaps.count > 0 {
            if healthSnaps[0].menstrual != CGFloat(HKCategoryValueMenstrualFlow.none.rawValue) {
                dates.append(date)
                date = date.addDays(days: menstrualFilterJump)
                continue
            }
        }
        date = date.addDays(days: 1)
    }

    return dates
}

/**
 Make menstrual butterfly plot.
 */
@inline(__always) func makeMenstrualButterfly(entriesE: [CGFloat?], entriesD: [CGFloat?], entriesA: [CGFloat?], entriesI: [CGFloat?]) -> ButterflyEntryStruct {
    var butterfly = ButterflyEntryStruct()
    butterfly.elevation = entriesE
    butterfly.depression = entriesD
    butterfly.anxiety = entriesA
    butterfly.irritability = entriesI
    return butterfly
}
