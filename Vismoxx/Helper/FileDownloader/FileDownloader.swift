import Foundation
import Firebase

typealias FileListCallback = (_ files: [FileDescription]) -> ()
typealias DownloadFileCallback = (_ path: String) -> ()
typealias FileListErrorCallback = (_ error: Error) -> ()
typealias Action = () -> ()


class FileDownloader {
    private var localStorage: LocalStorageProtocol?
    private let storage: Storage!
    private var queue = DispatchQueue(label: "file.download", qos: .background)
    
    func dispatch(_ action: @escaping Action) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
    
    init(storageUrl: String = "gs://vismoxx.appspot.com", local: LocalStorageProtocol? = nil){
        self.storage = Storage.storage(url: storageUrl)
        self.localStorage = local
    }
    
    func getFilesList(onSuccess: @escaping FileListCallback, onError: @escaping  FileListErrorCallback) {
        queue.async {
            let storageReference = self.storage.reference()
            storageReference.listAll { (result, error) in
                if let error = error {
                    self.dispatch {
                        onError(error)
                        return
                    }
                }
                var files = [FileDescription]()
                result.items.forEach { (item) in
                    files.append(FileDescription(name: item.name, path: item.fullPath))
                }
                self.dispatch {
                    onSuccess(files)
                }
            }
        }
    }
    func getFile(file: FileDescription, onSuccess: @escaping DownloadFileCallback, onError: @escaping  FileListErrorCallback) {
        queue.async { [weak self] in
            guard let local = self?.localStorage else {
                self?.dispatch {
                    onError(RuntimeError("No local storage provider"))
                }
                return
            }
            if local.isFileExists(fileName: file.name)  {
                self?.dispatch {
                    onSuccess(local.getFilePath(fileName: file.name).path)
                }
            } else {
                self?.downloadFile(file: file, onSuccess: onSuccess, onError: onError)
            }
        }
    }
    private func downloadFile(file: FileDescription, onSuccess: @escaping DownloadFileCallback, onError: @escaping  FileListErrorCallback) {
        let islandRef = self.storage.reference().child(file.path)
        guard let localURL = self.localStorage?.getFilePath(fileName: file.name) else
        {
            onError(RuntimeError("Directory error"))
            return
        }
        islandRef.write(toFile: localURL) { url, error in
            if let error = error {
                self.dispatch {
                    onError(error)
                }
            } else {
                self.dispatch {
                    onSuccess(localURL.path)
                }
            }
        }
    }
}
