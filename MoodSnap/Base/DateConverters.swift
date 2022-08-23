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
    func getComponents() -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year], from: self)
    }

    func addDays(days: Int) -> Date {
        let daysComponents = DateComponents(day: days)
        return Calendar.current.date(byAdding: daysComponents, to: self)!
    }
    
    func addSeconds(seconds: Int) -> Date {
        let daysComponents = DateComponents(second: seconds)
        return Calendar.current.date(byAdding: daysComponents, to: self)!
    }

    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    func dateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func startOfDay() -> Date {
        let start = Calendar.current.startOfDay(for: self)
        return start
    }
    
    func endOfDay() -> Date {
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
    func numberOfDaysBetween(from: Date, to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}
