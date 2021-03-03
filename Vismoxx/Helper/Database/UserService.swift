
import Foundation
import Firebase

typealias UsersCallback = ([User]) -> ()
typealias ErrorCallback = (String) -> ()

protocol UserServiceProtocol {
    func getUsers(onSuccess: @escaping UsersCallback, onError: @escaping ErrorCallback)
}

class UserService: UserServiceProtocol {
    private let dbInstance: DatabaseReference
    init() {
        dbInstance = Database.database().reference(withPath: "user")
    }
    
    func getUsers(onSuccess: @escaping UsersCallback, onError: @escaping ErrorCallback) {
        dbInstance.observe(.value) { (users) in
            var result = [User]()
            users.children.forEach { (rawUser) in
                if let snapshot = rawUser as? DataSnapshot, let data = User(snapshot: snapshot) {
                    result.append(data)
                } else {
                    onError("Problem with: \(rawUser)")
                }
            }
            onSuccess(result)
        }
    }
}
