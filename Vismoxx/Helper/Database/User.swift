
import Foundation
import Firebase

struct User: Codable {
    let name: String
    let phone: String
    let email: String
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let phone = value["phone"] as? String,
            let email = value["email"] as? String
        else {
            return nil
        }
        self.name = name
        self.phone = phone
        self.email = email
    }
}

