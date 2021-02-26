import Foundation
import UIKit
import ObjectMapper

// MARK: - UserStaticData
class UserStaticData: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.emailAcls <- map["emailAcls"]
        self.userRoles <- map["userRoles"]
        self.moduleAcls <- map["moduleAcls"]
        self.deviceAcls <- map["deviceAcls"]
    }
    var emailAcls, userRoles, moduleAcls, deviceAcls: [DeviceACL]?

    init(emailAcls: [DeviceACL]?, userRoles: [DeviceACL]?, moduleAcls: [DeviceACL]?, deviceAcls: [DeviceACL]?) {
        self.emailAcls = emailAcls
        self.userRoles = userRoles
        self.moduleAcls = moduleAcls
        self.deviceAcls = deviceAcls
    }
}
