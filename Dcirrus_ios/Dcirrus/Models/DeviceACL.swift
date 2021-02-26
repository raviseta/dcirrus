import Foundation
import UIKit
import ObjectMapper
// MARK: - DeviceACL
class DeviceACL : Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.deviceACLDescription <- map["deviceACLDescription"]
    }
    
    var id: Int?
    var name, deviceACLDescription: String?

    init(id: Int?, name: String?, deviceACLDescription: String?) {
        self.id = id
        self.name = name
        self.deviceACLDescription = deviceACLDescription
    }
}
