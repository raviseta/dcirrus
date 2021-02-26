import Foundation
import UIKit
import ObjectMapper


// MARK: - Contact
class Contact: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.loginID <- map["loginID"]
        self.contactPhoneList <- map["contactPhoneList"]
        self.parity6 <- map["parity6"]
        self.lastName <- map["lastName"]
        self.phoneID <- map["phoneID"]
        self.id <- map["id"]
        self.userRoleID <- map["userRoleID"]
        self.country <- map["country"]
        self.phoneType <- map["phoneType"]
        self.state <- map["state"]
        self.emailTypeDesc <- map["emailTypeDesc"]
        self.middleName <- map["middleName"]
        self.faxType <- map["faxType"]
        self.firstName <- map["firstName"]
        self.address <- map["address"]
        self.contactEmailList <- map["contactEmailList"]
        self.lastSynced <- map["lastSynced"]
        self.parity5 <- map["parity5"]
        self.sharedDataUsage <- map["sharedDataUsage"]
        self.barID <- map["barID"]
        self.picture <- map["picture"]
        self.stateBar <- map["stateBar"]
        self.website <- map["website"]
        self.emailID <- map["emailID"]
        self.contactAddressList <- map["contactAddressList"]
        self.phoneCountryCode <- map["phoneCountryCode"]
        self.addressType <- map["addressType"]
        self.parity4 <- map["parity4"]
        self.faxID <- map["faxID"]
        self.email <- map["email"]
        self.faxTypeDesc <- map["faxTypeDesc"]
        self.emailType <- map["emailType"]
        self.phoneNumber <- map["phoneNumber"]
        self.userStatus <- map["userStatus"]
        self.zip <- map["zip"]
        self.status <- map["status"]
        self.city <- map["city"]
        self.faxCountryCode <- map["faxCountryCode"]
        self.parity3 <- map["parity3"]
        self.addressTypeDesc <- map["addressTypeDesc"]
        self.phoneTypeDesc <- map["phoneTypeDesc"]
        self.parity2 <- map["parity2"]
        self.persoanDataUsage <- map["persoanDataUsage"]
        self.contactFaxList <- map["contactFaxList"]
        self.userRoleName <- map["userRoleName"]
        self.fax <- map["fax"]
        self.userTypeID <- map["userTypeID"]
        self.parity1 <- map["parity1"]
        self.addressID <- map["addressID"]
        self.companyName <- map["companyName"]
        self.userID <- map["userID"]
        self.userAMSEmailID <- map["userAMSEmailID"]
    }
    
    var loginID, contactPhoneList, parity6, lastName: String?
    var phoneID, id, userRoleID: Int?
    var country: String?
    var phoneType: Int?
    var state, emailTypeDesc, middleName: String?
    var faxType: Int?
    var firstName, address: String?
    var contactEmailList: [ContactEmailList]?
    var lastSynced: Int?
    var parity5, sharedDataUsage, barID, picture: String?
    var stateBar, website: String?
    var emailID: Int?
    var contactAddressList: String?
    var phoneCountryCode, addressType: Int?
    var parity4: String?
    var faxID: Int?
    var email, faxTypeDesc: String?
    var emailType: Int?
    var phoneNumber, userStatus, zip, status: String?
    var city: String?
    var faxCountryCode: Int?
    var parity3, addressTypeDesc, phoneTypeDesc, parity2: String?
    var persoanDataUsage, contactFaxList, userRoleName, fax: String?
    var userTypeID, parity1: String?
    var addressID: Int?
    var companyName: String?
    var userID: Int?
    var userAMSEmailID: String?

    init(loginID: String?, contactPhoneList: String?, parity6: String?, lastName: String?, phoneID: Int?, id: Int?, userRoleID: Int?, country: String?, phoneType: Int?, state: String?, emailTypeDesc: String?, middleName: String?, faxType: Int?, firstName: String?, address: String?, contactEmailList: [ContactEmailList]?, lastSynced: Int?, parity5: String?, sharedDataUsage: String?, barID: String?, picture: String?, stateBar: String?, website: String?, emailID: Int?, contactAddressList: String?, phoneCountryCode: Int?, addressType: Int?, parity4: String?, faxID: Int?, email: String?, faxTypeDesc: String?, emailType: Int?, phoneNumber: String?, userStatus: String?, zip: String?, status: String?, city: String?, faxCountryCode: Int?, parity3: String?, addressTypeDesc: String?, phoneTypeDesc: String?, parity2: String?, persoanDataUsage: String?, contactFaxList: String?, userRoleName: String?, fax: String?, userTypeID: String?, parity1: String?, addressID: Int?, companyName: String?, userID: Int?, userAMSEmailID: String?) {
        self.loginID = loginID
        self.contactPhoneList = contactPhoneList
        self.parity6 = parity6
        self.lastName = lastName
        self.phoneID = phoneID
        self.id = id
        self.userRoleID = userRoleID
        self.country = country
        self.phoneType = phoneType
        self.state = state
        self.emailTypeDesc = emailTypeDesc
        self.middleName = middleName
        self.faxType = faxType
        self.firstName = firstName
        self.address = address
        self.contactEmailList = contactEmailList
        self.lastSynced = lastSynced
        self.parity5 = parity5
        self.sharedDataUsage = sharedDataUsage
        self.barID = barID
        self.picture = picture
        self.stateBar = stateBar
        self.website = website
        self.emailID = emailID
        self.contactAddressList = contactAddressList
        self.phoneCountryCode = phoneCountryCode
        self.addressType = addressType
        self.parity4 = parity4
        self.faxID = faxID
        self.email = email
        self.faxTypeDesc = faxTypeDesc
        self.emailType = emailType
        self.phoneNumber = phoneNumber
        self.userStatus = userStatus
        self.zip = zip
        self.status = status
        self.city = city
        self.faxCountryCode = faxCountryCode
        self.parity3 = parity3
        self.addressTypeDesc = addressTypeDesc
        self.phoneTypeDesc = phoneTypeDesc
        self.parity2 = parity2
        self.persoanDataUsage = persoanDataUsage
        self.contactFaxList = contactFaxList
        self.userRoleName = userRoleName
        self.fax = fax
        self.userTypeID = userTypeID
        self.parity1 = parity1
        self.addressID = addressID
        self.companyName = companyName
        self.userID = userID
        self.userAMSEmailID = userAMSEmailID
    }
}
