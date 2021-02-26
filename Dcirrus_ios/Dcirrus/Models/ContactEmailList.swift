import Foundation
import UIKit
import ObjectMapper
// MARK: - ContactEmailList
class ContactEmailList: Mappable {
    required init?(map: Map) {
        self.status <- map["status"]
        self.primary <- map["primary"]
        self.id <- map["id"]
        self.emailTypeDesc <- map["emailTypeDesc"]
        self.contactID <- map["contactID"]
        self.email <- map["email"]
        self.type <- map["type"]
    }
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.primary <- map["primary"]
        self.id <- map["id"]
        self.emailTypeDesc <- map["emailTypeDesc"]
        self.contactID <- map["contactID"]
        self.email <- map["email"]
        self.type <- map["type"]
    }
    
    var status: String?
    var primary, id: Int?
    var emailTypeDesc: String?
    var contactID: Int?
    var email: String?
    var type: Int?

    init(status: String?, primary: Int?, id: Int?, emailTypeDesc: String?, contactID: Int?, email: String?, type: Int?) {
        self.status = status
        self.primary = primary
        self.id = id
        self.emailTypeDesc = emailTypeDesc
        self.contactID = contactID
        self.email = email
        self.type = type
    }
}
