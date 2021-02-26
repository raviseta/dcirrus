import Foundation
import UIKit
import ObjectMapper
// MARK: - Object
class ObjectLocal: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.userOTPDto <- map["userOTPDto"]
        self.deviceAcls <- map["deviceAcls"]
        self.emailAcls <- map["emailAcls"]
        self.acmAcls <- map["acmAcls"]
        self.syncType <- map["syncType"]
        self.type <- map["type"]
        self.loginID <- map["loginID"]
        self.contactDto <- map["contactDto"]
        self.userRoleID <- map["userRoleID"]
        self.mailBoxs <- map["mailBoxs"]
        self.contactsList <- map["contactsList"]
        self.grantedProxy <- map["grantedProxy"]
        self.role <- map["role"]
        self.userStaticData <- map["userStaticData"]
        self.billingRate <- map["billingRate"]
        self.daysRemaining <- map["daysRemaining"]
        self.moduleAcls <- map["moduleAcls"]
        self.autoLogin <- map["autoLogin"]
    }
    var userOTPDto: String?
    var deviceAcls: [Int]?
    var emailAcls, acmAcls, syncType, type: String?
    var loginID: String?
    var contactDto: Contact?
    var userRoleID: Int?
    var mailBoxs: String?
    var contactsList: [Contact]?
    var grantedProxy, role: String?
    var userStaticData: UserStaticData?
    var billingRate, daysRemaining: Int?
    var moduleAcls: [Int]?
    var autoLogin: Int?

    init(userOTPDto: String?, deviceAcls: [Int]?, emailAcls: String?, acmAcls: String?, syncType: String?, type: String?, loginID: String?, contactDto: Contact?, userRoleID: Int?, mailBoxs: String?, contactsList: [Contact]?, grantedProxy: String?, role: String?, userStaticData: UserStaticData?, billingRate: Int?, daysRemaining: Int?, moduleAcls: [Int]?, autoLogin: Int?) {
        self.userOTPDto = userOTPDto
        self.deviceAcls = deviceAcls
        self.emailAcls = emailAcls
        self.acmAcls = acmAcls
        self.syncType = syncType
        self.type = type
        self.loginID = loginID
        self.contactDto = contactDto
        self.userRoleID = userRoleID
        self.mailBoxs = mailBoxs
        self.contactsList = contactsList
        self.grantedProxy = grantedProxy
        self.role = role
        self.userStaticData = userStaticData
        self.billingRate = billingRate
        self.daysRemaining = daysRemaining
        self.moduleAcls = moduleAcls
        self.autoLogin = autoLogin
    }
}
