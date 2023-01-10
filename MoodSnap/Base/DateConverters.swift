import SwiftUI

/**
 Comparison functions for date components
 */
extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let now = Date()
        let comparison = Calendar.current.date(byAdding: lhs, to: now)! < Calendar.current.date(byAdding: rhs, to: now)!
        return comparison
    }

    public static func <= (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let now = Date()
        let comparison = Calendar.current.date(byAdding: lhs, to: now)! <= Calendar.current.date(byAdding: rhs, to: now)!
        return comparison
    }

    public static func > (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let now = Date()
        let comparison = Calendar.current.date(byAdding: lhs, to: now)! > Calendar.current.date(byAdding: rhs, to: now)!
        return comparison
    }

    public static func >= (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let now = Date()
        let comparison = Calendar.current.date(byAdding: lhs, to: now)! >= Calendar.current.date(byAdding: rhs, to: now)!
        return comparison
    }
}

/**
 Extra utilities for `Date` type.
 */
extension Date {
    @inline(__always) func getComponents() -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year], from: self)
    }

    @inline(__always) func addDays(days: Int) -> Date {
        let daysComponents = DateComponents(day: days)
        return Calendar.current.date(byAdding: daysComponents, to: self)!
    }
    
    @inline(__always) func addSeconds(seconds: Int) -> Date {
        let daysComponents = DateComponents(second: seconds)
        return Calendar.current.date(byAdding: daysComponents, to: self)!
    }

    @inline(__always) func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    @inline(__always) func dateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    @inline(__always) func startOfDay() -> Date {
        let start = Calendar.current.startOfDay(for: self)
        return start
    }
    
    @inline(__always) func endOfDay() -> Date {
        var end = Calendar.current.startOfDay(for: self)
        end = end.addDays(days: 1)
        end = end.addSeconds(seconds: -1)
        return end
    }
}

/**
 Extra utilities for `Calendar` type.
 */
extension Calendar {
    @inline(__always) func numberOfDaysBetween(from: Date, to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}

/**
 Get date range of `moodSnaps` in days.
 */
@inline(__always) func dateRange(moodSnaps: [MoodSnapStruct]) -> Int {
    let first = getFirstDate(moodSnaps: moodSnaps)
    let days = Calendar.current.numberOfDaysBetween(from: first, to: Date()) + 1
    return days
}

/**
 Convert `timescale` to days.
 */
@inline(__always) func getTimescale(timescale: Int, moodSnaps: [MoodSnapStruct]) -> Int {
    if timescale == TimeScaleEnum.all.rawValue {
        return max(dateRange(moodSnaps: moodSnaps), TimeScaleEnum.month.rawValue)
    } else {
        return timescale
    }
}
