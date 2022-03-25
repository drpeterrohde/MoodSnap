import SwiftUI
import UniformTypeIdentifiers

/**
 Struct for JSON file.
 */
struct JSONFile: FileDocument {
    static var readableContentTypes = [UTType.json]
    var text = ""

    init(string: String = "") {
        text = string
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

/**
 Encode `data` struct into a JSON `String`.
 */
func encodeJSONString(data: DataStoreStruct) -> String {
    do {
        let jsonData = try JSONEncoder().encode(data)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    } catch {
        print("JSON encoding error")
    }
    return ""
}

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

/**
 Decode a JSON `data` string into a struct.
 */
func decodeJSONString(url: URL) -> DataStoreStruct {
    var data = DataStoreStruct()
    do {
        url.startAccessingSecurityScopedResource()
        let rawData = try Data(contentsOf: url)
        data = try JSONDecoder().decode(DataStoreStruct.self, from: rawData)
        url.stopAccessingSecurityScopedResource()
    } catch {
        print ("Failed to import backup file")
        print (error.localizedDescription)
    }
    return data
}

func decodeJSONString(data: Data) -> DataStoreStruct {
    var decodedData = DataStoreStruct()
    do {
        decodedData = try JSONDecoder().decode(DataStoreStruct.self, from: data)
    } catch {
        print ("Failed to import backup file")
        print (error.localizedDescription)
    }
    return decodedData
}