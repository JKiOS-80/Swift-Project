import Foundation

struct FileDescription {
    let name: String
    let path: String
}
struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

class FileStorage: LocalStorageProtocol {
    var storageFolder: String {
        "models"
    }
    
    func isFileExists(fileName: String) -> Bool {
        let url = getFilePath(fileName: fileName)
        return FileManager.default.fileExists(atPath: url.path)
    }
}

protocol LocalStorageProtocol {
    var storageFolder: String { get }
    func isFileExists(fileName: String) -> Bool
}
extension LocalStorageProtocol {
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0].appendingPathComponent(storageFolder)
        return documentsDirectory
    }
    func getFilePath(fileName: String) -> URL {
        return getDirectory().appendingPathComponent(fileName)
    }
}
