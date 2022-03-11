import SwiftUI

func calculateDateAndTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    let dateString = dateFormatter.string(from: date)
    return dateString
}

func calculateDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    let dateString = dateFormatter.string(from: date)
    return dateString
}

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
