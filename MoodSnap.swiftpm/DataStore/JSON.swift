import SwiftUI
import UniformTypeIdentifiers

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

func decodeJSONString(data: String) -> DataStoreStruct? {
    do {
        let jsonData = try JSONEncoder().encode(data)
        let decoded = try JSONDecoder().decode(DataStoreStruct.self, from: jsonData)
        return decoded
    } catch {
        print("JSON decoding error")
    }
    return nil
}
