/*
/**
 Get list of visible activities.
 */
func getVisibleActivityList(data: DataStoreStruct) -> [String] {
    var list: [String] = []
    
    for i in 0..<activityList.count {
        if (data.settings.activityVisibility[activityListIndex[i]]) {
            list.append(activityList[i])
        }
    }
    
    for i in 0..<socialList.count {
        if (data.settings.socialVisibility[socialListIndex[i]]) {
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
        if (data.settings.symptomVisibility[symptomListIndex[i]]) {
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
