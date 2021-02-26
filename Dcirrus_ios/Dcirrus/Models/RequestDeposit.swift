//
//  RequestDeposit.swift
//  Dcirrus
//
//  Created by raviseta on 15/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestDeposit {
    
    var folderId: String = ""
    var serverURL: String = ""
    var message : String = ""
    var subject: String = ""
    var userName: String = ""
    var folderType: String = ""
    var emailIds = [Dictionary<String,Any>]()
    
    func toDictionary() -> [String : Any] {
        return APIManager.shared.toDictionary(modelObject: self)
    }
    
}
class RequestShare {
    
    
    /*
     "docId": [],
         
         "expirationDate": "2031-02-06T14:02:00Z",
         "allowDownload": "Y",
         "allowPrint": "Y",
         "addWaterMark": 1,
         "allowUpload": 1,
         "toSign": 0
     */
    
    var folderId: String = ""
    var serverURL: String = ""
    var message : String = ""
    var subject: String = ""
    var userName: String = ""
    var folderType: String = ""
    var expirationDate: String = "2031-02-06T14:02:00Z"
    
    var allowDownload: String = ""
    var allowPrint: String = ""
    var addWaterMark: Int = 1
    var allowUpload: Int = 1
    var toSign: Int = 0
    
    var emailidList = [Dictionary<String,Any>]()
    var docId = [String]()
    
    func toDictionary() -> [String : Any] {
        return APIManager.shared.toDictionary(modelObject: self)
    }
    
}

// MARK: - EmailID
class EmailID  {
    
    var emailId : String = ""
    var phoneNumber: String = ""
    var isKeySMS : Int = -1
    var isKeyEmail: Int = -1

    func toDictionary() -> [String : Any] {
        return APIManager.shared.toDictionary(modelObject: self)
    }
}

class RequestDepositResponse : Mappable {
    
    var messageCode: Int = -1
    var message: String = ""
    var error: Bool = false
    var object :  Int = -1
    var action: String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.messageCode <- map["messageCode"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.object <- map["object"]
        self.action <- map["action"]
    }
    

}
