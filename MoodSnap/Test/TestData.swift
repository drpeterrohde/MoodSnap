import SwiftUI

/**
 Make demonstration data.
 */
func makeDemoData() -> [MoodSnapStruct] {
    var moodSnaps: [MoodSnapStruct] = []
    let max = 50

    // Size & miss rate
    let demoDataRandomMiss: CGFloat = 0.1

    // Events
    var event1 = MoodSnapStruct()
    event1.snapType = .event
    event1.timestamp = Date().addDays(days: -50)
    event1.event = "New job"
    moodSnaps.append(event1)

    var event2 = MoodSnapStruct()
    event2.snapType = .event
    event2.timestamp = Date().addDays(days: -20)
    event2.event = "Changed meds"
    moodSnaps.append(event2)

    // Segment
    for i in 1 ... 50 {
        var moodSnap = MoodSnapStruct()
        moodSnap.elevation = CGFloat(Int.random(in: 1 ... 2))
        moodSnap.depression = 4.0 // CGFloat(Int.random(in: 3...4))
        moodSnap.anxiety = round(CGFloat.random(in: 0 ... 0.6))
        moodSnap.irritability = round(CGFloat.random(in: 1 ... 1.6))
        moodSnap.timestamp = Date().addDays(days: -i)
        if demoDataRandomMiss < CGFloat.random(in: 0.0 ..< 1.0) {
            moodSnaps.append(moodSnap)
        }
    }

    // Segment
    for i in 1 ... max {
        var moodSnap = MoodSnapStruct()
        moodSnap.elevation = round(CGFloat(Int.random(in: 0 ... 4)) * CGFloat(i) / CGFloat(max))
        moodSnap.depression = 0
        moodSnap.anxiety = CGFloat(Int.random(in: 3 ... 4))
        moodSnap.irritability = round(CGFloat.random(in: 2 ... 2.5))
        moodSnap.timestamp = Date().addDays(days: -(i + max))
        if demoDataRandomMiss < CGFloat.random(in: 0.0 ..< 1.0) {
            moodSnaps.append(moodSnap)
        }
    }

    for i in 0 ..< moodSnaps.count {
        if Float.random(in: 0 ... 1) < 0.1 {
            moodSnaps[i].activities[0] = true
        }
        if Float.random(in: 0 ... 1) < 0.1 {
            moodSnaps[i].activities[1] = true
        }
        if Float.random(in: 0 ... 1) < 0.1 {
            moodSnaps[i].social[0] = true
        }
        if Float.random(in: 0 ... 1) < 0.1 {
            moodSnaps[i].symptoms[1] = true
        }
    }

    let sorted = sortByDate(moodSnaps: moodSnaps)
    return sorted
}
