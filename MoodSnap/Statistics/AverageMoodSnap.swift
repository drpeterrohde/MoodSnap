import SwiftUI

/**
 Return a `MoodSnapStruct` of the average of those in a given `timescale`.
 */
@inline(__always) func averageMoodSnap(timescale: Int, moodSnaps: [MoodSnapStruct], flatten: Bool = true) -> MoodSnapStruct? {
    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: flatten)
    let average: [CGFloat?] = average(moodSnaps: windowSnaps)

    if (average[0] == nil) || (average[1] == nil) || (average[2] == nil) || (average[3] == nil) {
        return nil
    } else {
        var averageMoodSnap = MoodSnapStruct()
        averageMoodSnap.elevation = average[0]!
        averageMoodSnap.depression = average[1]!
        averageMoodSnap.anxiety = average[2]!
        averageMoodSnap.irritability = average[3]!
        return averageMoodSnap
    }
}

/**
 Return a `MoodSnapStruct` of the volatility of those in a given `timescale`.
 */
@inline(__always) func averageVolatilityMoodSnap(timescale: Int, moodSnaps: [MoodSnapStruct]) -> MoodSnapStruct? {
    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: moodSnaps,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: false)
    let volatility: [CGFloat?] = volatility(moodSnaps: windowSnaps)

    if (volatility[0] == nil) || (volatility[1] == nil) || (volatility[2] == nil) || (volatility[3] == nil) {
        return nil
    } else {
        var averageVolatilityMoodSnap = MoodSnapStruct()
        averageVolatilityMoodSnap.elevation = 2 * volatility[0]!
        averageVolatilityMoodSnap.depression = 2 * volatility[1]!
        averageVolatilityMoodSnap.anxiety = 2 * volatility[2]!
        averageVolatilityMoodSnap.irritability = 2 * volatility[3]!
        return averageVolatilityMoodSnap
    }
}
