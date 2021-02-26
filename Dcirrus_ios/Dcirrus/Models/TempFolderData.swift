//
//  TempFolderData.swift
//  Dcirrus
//
//  Created by Yobored on 10/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
// MARK: - DeviceACL
class TempFolderData : Mappable {
    /*
     
     var unIndexDocumentsList: [UnIndexDocumentList]?
     var folderList : String = ""
     var parentFolderPath : String = ""
     var maxLimit : Int = -1
     var noOfFiles : Int = -1
     var totalDocumentCount: Int = -1
     var unIndexFoldersList: [UnIndexDocumentList]?
     var unIndexSharedFolderSecurityDto: String = ""
     */
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.unIndexDocumentsList <- map["unIndexDocumentsList"]
        self.unIndexFoldersList <- map["unIndexFoldersList"]
        self.folderList <- map["folderList"]

        self.maxLimit <- map["maxLimit"]
        self.noOfFiles <- map["noOfFiles"]
        self.totalDocumentCount <- map["totalDocumentCount"]
        
        self.unIndexSharedFolderSecurityDto <- map["unIndexSharedFolderSecurityDto"]
        self.parentFolderPath <- map["parentFolderPath"]

    }
    
    var unIndexDocumentsList: [UnIndexDocumentList]?
    var unIndexFoldersList: [DataObject]?
    var unIndexSharedFolderSecurityDto: String?
    var folderList: [DataObject]?
    var maxLimit: Int?
    var noOfFiles: Int?
    var totalDocumentCount: Int?
    
    var parentFolderPath: String?
  
    init() {
    }
}
