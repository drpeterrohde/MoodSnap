import SwiftUI

/**
 Return a `MoodSnapStruct` of the average of those in a given `timescale`.
 */
@inline(__always) func averageMoodSnap(timescale: Int, data: DataStoreClass) -> MoodSnapStruct? {
//    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps,
//                                               date: Date(),
//                                               windowStart: -timescale,
//                                               windowEnd: 0,
//                                               flatten: true) ???
    let windowSnaps = getMoodSnapsByDateWindow(data: data,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: true)
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
@inline(__always) func averageVolatilityMoodSnap(timescale: Int, data: DataStoreClass) -> MoodSnapStruct? {
//    let windowSnaps = getMoodSnapsByDateWindow(moodSnaps: data.moodSnaps,
//                                               date: Date(),
//                                               windowStart: -timescale,
//                                               windowEnd: 0,
//                                               flatten: false) ???
    let windowSnaps = getMoodSnapsByDateWindow(data: data,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: false)
    let volatility: [CGFloat?] = volatility(moodSnaps: windowSnaps)

    if (volatility[0] == nil) || (volatility[1] == nil) || (volatility[2] == nil) || (volatility[3] == nil) {
        return nil
    } else {
        var averageMoodSnap = MoodSnapStruct()
        averageMoodSnap.elevation = 2 * volatility[0]!
        averageMoodSnap.depression = 2 * volatility[1]!
        averageMoodSnap.anxiety = 2 * volatility[2]!
        averageMoodSnap.irritability = 2 * volatility[3]!
        return averageMoodSnap
    }
}
