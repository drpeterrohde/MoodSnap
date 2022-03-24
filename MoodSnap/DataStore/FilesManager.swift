//import SwiftUI
//
//class FilesManager {
//    enum Error: Swift.Error {
//        case fileAlreadyExists
//        case invalidDirectory
//        case writtingFailed
//        case fileNotExists
//        case readingFailed
//    }
//
//    let fileManager: FileManager
//    let filename = "data.json"
//
//    init(fileManager: FileManager = .default) {
//        self.fileManager = fileManager
//    }
//
//    private func makeURL(forFileNamed fileName: String) -> URL? {
//        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Failed to get file manager URL")
//            return nil
//        }
//        print(url.appendingPathComponent(fileName))
//        return url.appendingPathComponent(fileName)
//    }
//
//    func save(data: Data) {
//        guard let url = makeURL(forFileNamed: filename) else {
//            print("Invalid URL directory")
//            return
//        }
//
//        do {
//            try data.write(to: url, options: .atomic)
//            print("Save successful")
//        } catch {
//            print("Save failed")
//        }
//    }
//
//    func save(data: DataStoreStruct) {
//        let dataString: String = encodeJSONString(data: data)
//        save(data: Data(dataString.utf8))
//    }
//
//    func read() -> DataStoreStruct {
//        do {
//            let data: Data = try read()
//            let dataStore: DataStoreStruct = try JSONDecoder().decode(DataStoreStruct.self, from: data)
//            print("Opened data.json")
//            return dataStore
//        } catch {
//            print("Opened with new DataStoreStruct")
//            return DataStoreStruct()
//        }
//    }
//
//    func read() throws -> Data {
//        guard let url = makeURL(forFileNamed: filename) else {
//            print("Invaid URL")
//            throw Error.invalidDirectory
//        }
//        if !fileManager.fileExists(atPath: url.absoluteString) {
//            save(data: DataStoreStruct())
//            print("Made new data.json file")
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            return data
//        } catch {
//            print("Convert to Data failed")
//            throw Error.readingFailed
//        }
//    }
//}
