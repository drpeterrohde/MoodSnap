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
func encodeJSONString(data: DataStoreClass) -> String {
    do {
        let jsonData = try JSONEncoder().encode(data.toStruct())
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    } catch {
    }
    return ""
}

/**
 Decode a JSON `url`  into a `DataStoreClass`.
 */
func decodeJSONString(url: URL) -> DataStoreStruct {
    var data = DataStoreStruct()
    do {
        _ = url.startAccessingSecurityScopedResource()
        let rawData = try Data(contentsOf: url)
        data = try JSONDecoder().decode(DataStoreStruct.self, from: rawData)
        url.stopAccessingSecurityScopedResource()
    } catch {
    }
    return data
}

/**
 Decode JSON `data` into a `DataStoreSturct`.
 */
func decodeJSONString(data: Data) -> DataStoreStruct {
    var decodedData = DataStoreStruct()
    do {
        decodedData = try JSONDecoder().decode(DataStoreStruct.self, from: data)
    } catch {
    }
    return decodedData
}
