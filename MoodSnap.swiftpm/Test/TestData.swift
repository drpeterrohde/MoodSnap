import SwiftUI

func makeDemoData(size: Int) -> [MoodSnapStruct] {
    var moodSnaps: [MoodSnapStruct] = []
    let max = 50
    let date = Date()
    
    // Segment
    for i in 1...max {
        var moodSnap = MoodSnapStruct()
        moodSnap.elevation = CGFloat(Int.random(in: 1...2))
        moodSnap.depression = CGFloat(Int.random(in: 3...4))
        moodSnap.anxiety = round(CGFloat.random(in: 0...0.6))
        moodSnap.irritability = round(CGFloat.random(in: 1...1.6))
        moodSnap.timestamp = Calendar.current.date(byAdding: .day, value: i, to: date)!
        moodSnap.notes = "Test notes round 1"
        if (demoDataRandomMiss < CGFloat.random(in: 0.0..<1.0)) {
            moodSnaps.append(moodSnap)
        }
    }
    
    // Segment
    for i in 1...max {
        var moodSnap = MoodSnapStruct()
        moodSnap.elevation = round(CGFloat(Int.random(in: 0...4))*CGFloat(i)/CGFloat(max))
        moodSnap.depression = 4.0-round(CGFloat(Int.random(in: 0...4))*CGFloat(i)/CGFloat(max))
        moodSnap.anxiety = round(CGFloat.random(in: 0...0.6))
        moodSnap.irritability = round(CGFloat.random(in: 1...1.6))
        moodSnap.timestamp = Calendar.current.date(byAdding: .day, value: i+max, to: date)!
        moodSnap.notes = "Test notes round 1"
        if (demoDataRandomMiss < CGFloat.random(in: 0.0..<1.0)) {
            moodSnaps.append(moodSnap)
        }
    }
    
    let subseq = Array(moodSnaps.prefix(size))
    let sorted = sortByDate(moodSnaps: subseq)
    return sortByDate(moodSnaps: sorted)
}

