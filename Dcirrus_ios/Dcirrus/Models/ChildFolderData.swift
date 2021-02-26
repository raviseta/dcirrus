//
//  ChildFolderData.swift
//  Dcirrus
//
//  Created by Yobored on 10/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class ChildFolderData : NSObject,Mappable {
    
    var messageCode: Int = 0
    var message: String = ""
    var error: Bool = false
    
    var object :TempFolderData? = nil
    var tempObject1: [DataObject]? = nil
    var tempObject1Data: TempFolderData? = nil
    var tempObject2: [DataObject]? = nil
    var tempObject2Data: TempFolderData? = nil
    var tempObject3: [DataObject]? = nil
    var tempObject3Data: TempFolderData? = nil
    var tempObject4: [DataObject]? = nil
    var tempObject4Data: TempFolderData? = nil
    var tempObject5: [DataObject]? = nil
    var tempObject5Data: TempFolderData? = nil
    
    var action: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        messageCode <- map["messageCode"]
        message <- map["message"]
        error <- map["error"]
        object <- map["object"]
        tempObject1 <- map["tempObject1"]
        tempObject1Data <- map["tempObject1"]
        
        tempObject2 <- map["tempObject2"]
        tempObject2Data <- map["tempObject1"]
        tempObject3 <- map["tempObject3"]
        tempObject3Data <- map["tempObject3"]
        tempObject4 <- map["tempObject4"]
        tempObject4Data <- map["tempObject4"]
        tempObject5 <- map["tempObject5"]
        tempObject5Data <- map["tempObject5"]
        action <- map["action"]
        
    }
}
