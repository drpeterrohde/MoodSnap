import SwiftUI

struct DataStoreStruct: Identifiable, Codable {
    var id: UUID = UUID()
    var settings: SettingsStruct = SettingsStruct()
    var moodSnaps: [MoodSnapStruct] = makeDemoData(size: demoDataSize)
    var healthData: HealthKitDataStruct = HealthKitDataStruct()
}

class DataStore: ObservableObject {
    @Published var moodSnapData: [DataStoreStruct] = [DataStoreStruct()]
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("moodsnap.data")
    }
    
    static func load(completion: @escaping (Result<[DataStoreStruct], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let moodSnapData = try JSONDecoder().decode([DataStoreStruct].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(moodSnapData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(moodSnapData: [DataStoreStruct], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(moodSnapData)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(moodSnapData.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
