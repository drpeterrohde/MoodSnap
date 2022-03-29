/*
/**
 Get list of visible activities.
 */
func getVisibleActivityList(data: DataStoreStruct) -> [String] {
    var list: [String] = []
    
    for i in 0..<activityList.count {
        if (data.settings.activityVisibility[i]) {
            list.append(activityList[i])
        }
    }
    
    for i in 0..<socialList.count {
        if (data.settings.socialVisibility[i]) {
            list.append(socialList[i])
        }
    }
    
    return list
}

/**
 Get list of visible symtoms.
 */
func getVisibleSymptomList(data: DataStoreStruct) -> [String] {
    var list: [String] = []
    
    for i in 0..<symptomList.count {
        if (data.settings.symptomVisibility[i]) {
            list.append(symptomList[i])
        }
    }
    
    return list
}
 */


///**
// Extract year, month & day `DateComponents` for today.
// */
//func todaysDateComponents() -> DateComponents {
//    return Calendar.current.dateComponents([.day, .month, .year], from: Date())
//}

///**
// Extract year, month & day `DateComponents` for a given `date`.
// */
//func getDateComponents(date: Date) -> DateComponents? {
//    return Calendar.current.dateComponents([.day, .month, .year], from: date)
//}

///**
// Return the date `days` days ago from `date`.
// */
//func subtractDaysFromDate(date: Date, days: Int) -> Date? {
//    let dayComp = DateComponents(day: -days)
//    let date = Calendar.current.date(byAdding: dayComp, to: date)
//    return date
//}

///**
// Duplicate a `moodSnap` with a new UUID.
// */
//func duplicateMoodSnapStruct(moodSnap: MoodSnapStruct) {
//    var duplicate = moodSnap
//    duplicate.id = UUID()
//}

//
//class DataStore: ObservableObject {
//    @Published var moodSnapData: [DataStoreStruct] = [DataStoreStruct()]
//    
//    private static func fileURL() throws -> URL {
//        try FileManager.default.url(for: .documentDirectory,
//                                       in: .userDomainMask,
//                                       appropriateFor: nil,
//                                       create: false)
//            .appendingPathComponent("moodsnap.data")
//    }
//    
//    static func load(completion: @escaping (Result<[DataStoreStruct], Error>) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let fileURL = try fileURL()
//                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
//                    DispatchQueue.main.async {
//                        completion(.success([]))
//                    }
//                    return
//                }
//                let moodSnapData = try JSONDecoder().decode([DataStoreStruct].self, from: file.availableData)
//                DispatchQueue.main.async {
//                    completion(.success(moodSnapData))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//    
//    static func save(moodSnapData: [DataStoreStruct], completion: @escaping (Result<Int, Error>) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let data = try JSONEncoder().encode(moodSnapData)
//                let outfile = try fileURL()
//                try data.write(to: outfile)
//                DispatchQueue.main.async {
//                    completion(.success(moodSnapData.count))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//}





/**
 Return butterfly for a `date`.
 */
//func butterflyByDate(moodSnaps: [MoodSnapStruct], date: Date, maxWindow: Int) -> ButterflyEntryStruct {
//    var butterfly = ButterflyEntryStruct()
//
//    // Past
//    for window in -(maxWindow-1) ... -1 {
//        let thisAverage = averageByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date,
//            windowStart: window,
//            windowEnd: 0)
//        butterfly.elevation.append(thisAverage[0])
//        butterfly.depression.append(thisAverage[1])
//        butterfly.anxiety.append(thisAverage[2])
//        butterfly.irritability.append(thisAverage[3])
//
//        let thisVolatility = volatilityByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date,
//            windowStart: window,
//            windowEnd: 0)
//        butterfly.elevationVolatility.append(thisVolatility[0])
//        butterfly.depressionVolatility.append(thisVolatility[1])
//        butterfly.anxietyVolatility.append(thisVolatility[2])
//        butterfly.irritabilityVolatility.append(thisVolatility[3])
//    }
//
//    // Present
//    let thisAverage = averageByDateWindow(
//        moodSnaps: moodSnaps,
//        date: date,
//        windowStart: 0,
//        windowEnd: 0)
//    butterfly.elevation.append(thisAverage[0])
//    butterfly.depression.append(thisAverage[1])
//    butterfly.anxiety.append(thisAverage[2])
//    butterfly.irritability.append(thisAverage[3])
//
//    butterfly.elevationVolatility.append(nil)
//    butterfly.depressionVolatility.append(nil)
//    butterfly.anxietyVolatility.append(nil)
//    butterfly.irritabilityVolatility.append(nil)
//
//    // Future
//    for window in 1 ... (maxWindow-1) {
//        let thisAverage = averageByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date,
//            windowStart: 0,
//            windowEnd: window)
//
//        butterfly.elevation.append(thisAverage[0])
//        butterfly.depression.append(thisAverage[1])
//        butterfly.anxiety.append(thisAverage[2])
//        butterfly.irritability.append(thisAverage[3])
//
//        let thisVolatility = volatilityByDateWindow(
//            moodSnaps: moodSnaps,
//            date: date,
//            windowStart: 0,
//            windowEnd: window)
//        butterfly.elevationVolatility.append(thisVolatility[0])
//        butterfly.depressionVolatility.append(thisVolatility[1])
//        butterfly.anxietyVolatility.append(thisVolatility[2])
//        butterfly.irritabilityVolatility.append(thisVolatility[3])
//    }
//
//    return butterfly
//}

//func averageButterflyByDates(moodSnaps: [MoodSnapStruct], dates: [Date], maxWindow: Int) -> ButterflyEntryStruct? {
//    var butterflies: [ButterflyEntryStruct] = []
//
//    for date in dates {
//        let thisButterfly: ButterflyEntryStruct = butterflyByDate(
//            moodSnaps: moodSnaps,
//            date: date,
//            maxWindow: maxWindow)
//        butterflies.append(thisButterfly)
//    }
//
//    let butterfly = averageButterfly(butterflies: butterflies)
//    return butterfly
//}





/**
 Decode a JSON `data` string into a struct.
 */
//func decodeJSONString(data: String) -> DataStoreStruct? {
//    do {
//        let jsonData = try JSONEncoder().encode(data)
//        let decoded = try JSONDecoder().decode(DataStoreStruct.self, from: jsonData)
//        return decoded
//    } catch {
//        print("JSON decoding error")
//    }
//    return nil
//}
// data = try! JSONDecoder().decode(DataStoreStruct.self, from: rawData)




///**
// Average butterfly from an array of data `series`.
// */
//func averageButterfly(series: [[CGFloat?]]) -> [CGFloat?] {
//    var norms: [[CGFloat?]] = []
//
//    for item in series {
//        let norm = normSeries(series: item)
//        norms.append(norm)
//    }
//
//    let butterfly = averageSeries(series: norms)
//    return butterfly
//}

///**
// Average butterfly from an array of `butterflies`.
// */
//func averageButterfly(butterflies: [ButterflyEntryStruct]) -> ButterflyEntryStruct? {
//    if butterflies.count == 0 {
//        return nil
//    }
//
//    var averageButterfly = ButterflyEntryStruct()
//    averageButterfly.activity = butterflies[0].activity
//    averageButterfly.timestamp = butterflies[0].timestamp
//
//    var elevation: [[CGFloat?]] = []
//    var depression: [[CGFloat?]] = []
//    var anxiety: [[CGFloat?]] = []
//    var irritability: [[CGFloat?]] = []
//
//    var elevationVolatility: [[CGFloat?]] = []
//    var depressionVolatility: [[CGFloat?]] = []
//    var anxietyVolatility: [[CGFloat?]] = []
//    var irritabilityVolatility: [[CGFloat?]] = []
//
//    for butterfly in butterflies {
//        elevation.append(butterfly.elevation)
//        depression.append(butterfly.depression)
//        anxiety.append(butterfly.anxiety)
//        irritability.append(butterfly.irritability)
//
//        elevationVolatility.append(butterfly.elevationVolatility)
//        depressionVolatility.append(butterfly.depressionVolatility)
//        anxietyVolatility.append(butterfly.anxietyVolatility)
//        irritabilityVolatility.append(butterfly.irritabilityVolatility)
//    }
//
//    averageButterfly.elevation = averageSeries(series: elevation)
//    averageButterfly.depression = averageSeries(series: depression)
//    averageButterfly.anxiety = averageSeries(series: anxiety)
//    averageButterfly.irritability = averageSeries(series: irritability)
//
//    averageButterfly.elevationVolatility = averageSeries(series: elevationVolatility)
//    averageButterfly.depressionVolatility = averageSeries(series: depressionVolatility)
//    averageButterfly.anxietyVolatility = averageSeries(series: anxietyVolatility)
//    averageButterfly.irritabilityVolatility = averageSeries(series: irritabilityVolatility)
//
//    return averageButterfly
//}


///**
// Returns array of `moodSnaps` flattened on a per-day basis.
// */
//func getFlattenedMoodSnaps(moodSnaps: [MoodSnapStruct]) -> [MoodSnapStruct] {
//    let flattened = getMoodSnapsByDateWindow(moodSnaps: moodSnaps, date: Date(), windowStart: -100, windowEnd: 1, flatten: true)
//    // Make this more efficient ???
//    //print(flattened)
//    return flattened
//} ???

///**
// Return the element from `moodSnaps` with UUID `id` if it exists.
// */
//func getMoodSnapByUUID(moodSnaps: [MoodSnapStruct], id: UUID) -> MoodSnapStruct? {
//    if let item = moodSnaps.first(where: { $0.id == id }) {
//        return item
//    }
//    return nil
//} ???



// ???
//func averageByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int) -> [CGFloat?] {
//    let samples = getMoodSnapsByDateWindow(
//        moodSnaps: moodSnaps,
//        date: date,
//        windowStart: windowStart,
//        windowEnd: windowEnd,
//        flatten: true)
//    let average = average(moodSnaps: samples)
//    return average
//}

//func volatilityByDateWindow(moodSnaps: [MoodSnapStruct], date: Date, windowStart: Int, windowEnd: Int) -> [CGFloat?] {
//    let samples = getMoodSnapsByDateWindow(
//        moodSnaps: moodSnaps,
//        date: date,
//        windowStart: windowStart,
//        windowEnd: windowEnd,
//        flatten: false)
//    let volatility = volatility(moodSnaps: samples)
//    return volatility
//}

//func averageDifferentialForDates(moodSnaps: [MoodSnapStruct], dates: [Date], window: Int) -> [CGFloat?] {
//    var diffsE: [CGFloat?] = []
//    var diffsD: [CGFloat?] = []
//    var diffsA: [CGFloat?] = []
//    var diffsI: [CGFloat?] = []
//
//    for date in dates {
//        let thisDiff = averageDifferential(
//            moodSnaps: moodSnaps,
//            date: date,
//            window: window)
//        diffsE.append(thisDiff[0])
//        diffsD.append(thisDiff[1])
//        diffsA.append(thisDiff[2])
//        diffsI.append(thisDiff[3])
//    }
//
//    let diffE = average(data: diffsE)
//    let diffD = average(data: diffsD)
//    let diffA = average(data: diffsA)
//    let diffI = average(data: diffsI)
//
//    return [diffE, diffD, diffA, diffI]
//}

//func volatilityDifferentialForDates(moodSnaps: [MoodSnapStruct], dates: [Date], window: Int) -> [CGFloat?] {
//    var diffsE: [CGFloat?] = []
//    var diffsD: [CGFloat?] = []
//    var diffsA: [CGFloat?] = []
//    var diffsI: [CGFloat?] = []
//
//    for date in dates {
//        let thisDiff = volatilityDifferential(
//            moodSnaps: moodSnaps,
//            date: date,
//            window: window)
//        diffsE.append(thisDiff[0])
//        diffsD.append(thisDiff[1])
//        diffsA.append(thisDiff[2])
//        diffsI.append(thisDiff[3])
//    }
//
//    let diffE = average(data: diffsE)
//    let diffD = average(data: diffsE)
//    let diffA = average(data: diffsE)
//    let diffI = average(data: diffsE)
//
//    return [diffE, diffD, diffA, diffI]
//}



///**
// Enumeration of the different mood level and mood volatility types.
// */
//enum LevelsEnum: Int, CaseIterable {
//    case elevation = 0
//    case depression = 1
//    case anxiety = 2
//    case irritability = 3
//    case elevationVolatility = 4
//    case depressionVolatility = 5
//    case anxietyVolatility = 6
//    case irritabilityVolatility = 7
//}


//func DummyMoodSnapStruct() -> MoodSnapStruct {
//    var moodSnap = MoodSnapStruct()
//    moodSnap.elevation = -1
//    moodSnap.depression = -1
//    moodSnap.anxiety = -1
//    moodSnap.irritability = -1
//    return moodSnap
//}


///**
// Linearly translate a series such that its midpoint is 0.
// */
//func normSeries(series: [CGFloat?]) -> [CGFloat?] {
//    let midValue: CGFloat? = series[(series.count - 1)/2]
//    var normSeries: [CGFloat?] = []
//
//    for index in 0 ..< series.count {
//        if series[index] != nil && midValue != nil {
//            normSeries.append(series[index]! - midValue!)
//        } else {
//            normSeries.append(nil)
//        }
//    }
//
//    return normSeries
//}
