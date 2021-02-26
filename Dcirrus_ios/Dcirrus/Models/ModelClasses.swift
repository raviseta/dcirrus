//
//  ModelClasses.swift
//  Dcirrus
//
//  Created by raviseta on 19/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class UserValidate {
    var userName:String = ""
    var password:String = ""
    var lawFirmNumber:String = ""
    var deviceId:String = ""
    var captcaStr : String = "111111"
    var rememberMe : String = ""
    func toDictionary() -> [String : Any] {
        return APIManager.shared.toDictionary(modelObject: self)
    }
}
class DeviceInfo {
    var lawFirmNumber:String = ""
    var deviceId:String = ""
    var loginId : String = ""
    var remoteAddress : String = ""
    var deviceType:String = "iOS"
    var deviceName : String = "\(UIDevice.current.name)"
    var remoteAddressV4 : String = ""
    var geoLocation : String = ""
    var deviceToken : String = ""
    var regNew : String = "browser"
    
    func toDictionary() -> [String : Any] {
        return APIManager.shared.toDictionary(modelObject: self)
    }
    
}


class LoginResponse : NSObject,Mappable{
    
    var messageCode: Int = 0
    var message: String = ""
    var error: Bool = false
    var objectD: ObjectD? = nil
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
        objectD <- map["objectD"]
        action <- map["action"]
        
        
    }
    
}

class ObjectD : NSObject,Mappable{
    var id : Int = 0
    var lawFirmID : Int = 0
    var deviceID : Int = 0
    var userID: Int = 0
    var status: Bool = false
    var reasonCode: Int = 0
    var message: String = ""
    var name : String = ""
    var token: String = ""
    var action: String = ""
    var emailID : String = ""
    var s3Region: String = ""
    var caseModule: Int = 0
    var syncType : String = ""
    var accType : String = ""
    var tempAttr1 : String = ""
    var tempAttr2: String = ""
    var tempAttr3: String = ""
    var tempAttr4 : String = ""
    var tempAttr5 : String = ""
    var tempAttr6: String = ""
    var tempAttr7: String = ""
    var tempAttr8: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        id <- map["id"]
        self.lawFirmID <- map["lawFirmID"]
        self.deviceID <- map["deviceID"]
        self.userID <- map["userID"]
        self.status <- map["status"]
        self.reasonCode <- map["reasonCode"]
        self.message <- map["message"]
        self.name <- map["name"]
        self.token <- map["token"]
        
        
        self.emailID <- map["emailID"]
        self.s3Region <- map["s3Region"]
        self.caseModule <- map["caseModule"]
        self.syncType <- map["syncType"]
        self.accType <- map["accType"]
        self.tempAttr1 <- map["tempAttr1"]
        self.tempAttr2 <- map["tempAttr2"]
        self.tempAttr4 <- map["tempAttr4"]
        self.tempAttr5 <- map["tempAttr5"]
        self.tempAttr6 <- map["tempAttr6"]
        self.tempAttr8 <- map["tempAttr8"]
    }
}




class changePassword {
    
    var generateCode:Bool = false
    var deviceId:String = ""
    var password:String = ""
    var newPassword:String = ""
    var lawFirmNumber:Int = 0
    var userLoginId:Int = 0
    var token:String = ""
    var deviceType:String = "iPhone"
    
}

class GetRootFolders : NSObject,Mappable {
    
    var messageCode: Int = 0
    var message: String = ""
    var error: Bool = false
    
    var object :[DataObject]? = nil
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

class object : NSObject, Mappable {
    
    
    var id : Int = 0
    var fileID : Int = 0
    var userID : Int = 0
    var folderID: Int = 0
    var parentFolderID: Int = 0
    var storageFileName : NSNull?
    var fileName: NSNull?
    var fileSize: Int = 0
    var fileType: NSNull?
    var fileCreatedDate : Date?
    var fileModifiedDate: Date?
    var status: String = ""
    var deleteStatus: NSNull?
    var folderType : String = ""
    var source : String = ""
    var inboundSharedBy: String = ""
    var noOfFiles: Int = 0
    var fileLastModified: NSNull?
    var maxPartNo: Int = 0
    var fileUniqueID, sync: NSNull?
    var versionNumber: Int = 0
    var tag: NSNull?
    var flagImp: Int = 0
    var browser: NSNull?
    var isLocked : Int = 0
    var lockedBy : Int = 0
    var toSign: Int = 0
    var folderIndex : String = ""
    var fdIndex: String = ""
    var fileIndex, dataURL: NSNull?
    var fileCreatedLongTime : Int = 0
    var fileModifiedLongTime: Int = 0
    var folderPath : String = ""
    var folderPathLastChild : String = ""
    var dataRoomPath: String = ""
    var bucketPathMD5: NSNull?
    var totalCount: Int = 0
    var sourceUpload: NSNull?
    var folderPermissions : String = ""
    var folderNM: String = ""
    var collaboraterName: NSNull?
    var folderUserID : Int = 0
    var folderSize: Int = 0
    var upload: Bool = false
    
    required init?(map: Map) {
    }
    
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.fileID  <- map["fileID"]
        self.userID  <- map["userID"]
        self.folderID <- map["folderId"]
        self.parentFolderID <- map["parentFolderID"]
        self.storageFileName <- map["storageFileName"]
        self.fileName <- map["fileName"]
        self.fileSize <- map["fileSize"]
        self.fileType <- map["fileType"]
        self.fileCreatedDate <- map["fileCreatedDate"]
        self.fileModifiedDate <- map["fileModifiedDate"]
        self.status <- map["status"]
        self.deleteStatus <- map["deleteStatus"]
        self.folderType <- map["folderType"]
        self.source <- map["source"]
        self.inboundSharedBy <- map["inboundSharedBy"]
        self.noOfFiles <- map["noOfFiles"]
        self.fileLastModified <- map["fileLastModified"]
        self.maxPartNo <- map["maxPartNo"]
        self.fileUniqueID <- map["fileUniqueID"]
        self.sync <- map["sync"]
        self.versionNumber <- map["versionNumber"]
        self.tag <- map["tag"]
        self.flagImp <- map["flagImp"]
        self.browser <- map["browser"]
        self.isLocked <- map["isLocked"]
        self.lockedBy <- map["lockedBy"]
        self.toSign <- map["toSign"]
        self.folderIndex <- map["folderIndex"]
        self.fdIndex <- map["fdIndex"]
        self.fileIndex <- map["fileIndex"]
        self.dataURL <- map["dataURL"]
        self.fileCreatedLongTime <- map["fileCreatedLongTime"]
        self.fileModifiedLongTime <- map["fileModifiedLongTime"]
        self.folderPath <- map["folderPath"]
        self.folderPathLastChild <- map["folderPathLastChild"]
        self.dataRoomPath <- map["dataRoomPath"]
        self.bucketPathMD5 <- map["bucketPathMD5"]
        self.totalCount <- map["totalCount"]
        self.sourceUpload <- map["sourceUpload"]
        self.folderPermissions <- map["folderPermissions"]
        self.folderNM <- map["folderNM"]
        self.collaboraterName <- map["collaboraterName"]
        self.folderUserID <- map["folderUserID"]
        self.folderSize <- map["folderSize"]
        self.upload <- map["upload"]
        
    }
}

class PersonalFilesResponse : NSObject, Mappable {
    
    var messageCode: Int = -1
    var message: String = ""
    var error: Bool = false
    var object : PersonalFileObject?
    var action: String = ""
    
    func mapping(map: Map) {
        self.messageCode <- map["messageCode"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.object <- map["object"]
        self.action <- map["action"]
    }
    
    required init?(map: Map) {
        
    }
    
}

// MARK: - Object
class PersonalFileObject : NSObject, Mappable {
    
    var unIndexDocumentsList: [UnIndexDocumentList]?
    var folderList : String = ""
    var parentFolderPath : String = ""
    var maxLimit : Int = -1
    var noOfFiles : Int = -1
    var totalDocumentCount: Int = -1
    var unIndexFoldersList: [UnIndexDocumentList]?
    var unIndexSharedFolderSecurityDto: String = ""
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.unIndexDocumentsList <- map["unIndexDocumentsList"]
        self.folderList <- map["folderList"]
        self.parentFolderPath <- map["parentFolderPath"]
        self.maxLimit <- map["maxLimit"]
        self.noOfFiles <- map["noOfFiles"]
        self.totalDocumentCount <- map["totalDocumentCount"]
        self.unIndexFoldersList <- map["unIndexFoldersList"]
        self.unIndexSharedFolderSecurityDto <- map["unIndexSharedFolderSecurityDto"]
    }
}

// MARK: - UnIndexSList
class UnIndexDocumentList : NSObject, Mappable {
    
    var deleteType = eDeletedType.none
    var currentStatusOfDownload: eFileUploadDownloadStatus = .notStarted
    var id : Int = -1
    var fileID : Int = -1
    var userID : Int = -1
    var folderID: Int = -1
    var parentFolderID: Int = -1
    var storageFileName : String = ""
    var fileName: String = ""
    var fileSize: Int = -1
    var fileType: String?
    var fileCreatedDate, fileModifiedDate: Date?
    var status: Status?
    var deleteStatus: String?
    var folderType: FolderType?
    var source: String = ""
    var inboundSharedBy: String?
    var noOfFiles: Int = -1
    var fileLastModified: Date?
    var maxPartNo: Int = -1
    var fileUniqueID: String?
    var sync: String = ""
    var versionNumber: Int = -1
    var tag: String = ""
    var flagImp: Int = -1
    var browser: String?
    var isLocked : Int = -1
    var lockedBy : Int = -1
    var toSign: Int = -1
    var folderIndex: String = ""
    var fdIndex : String = ""
    var fileIndex: String?
    var dataURL: String = ""
    var fileCreatedLongTime : Int = -1
    var fileModifiedLongTime: Int = -1
    var folderPath: Folder?
    var folderPathLastChild: String?
    var dataRoomPath: DataRoomPath?
    var bucketPathMD5: String = ""
    var totalCount: Int = -1
    var sourceUpload: String = ""
    var folderPermissions: String?
    var folderNM: Folder?
    var collaboraterName: String = ""
    var folderUserID : Int = -1
    var folderSize: Int = -1
    var upload: Bool = false
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.fileID <- map["fileId"]
        self.userID <- map["userId"]
        self.folderID <- map["folderId"]
        self.parentFolderID <- map["parentFolderId"]
        self.storageFileName <- map["storageFileName"]
        self.fileName <- map["fileName"]
        self.fileSize <- map["fileSize"]
        self.fileType <- map["fileType"]
        self.fileCreatedDate <- map["fileCreatedDate"]
        self.fileModifiedDate <- map["fileModifiedDate"]
        self.status <-  map["status"]
        self.deleteStatus <- map["deleteStatus"]
        self.folderType <- map["folderType"]
        self.source <- map["source"]
        self.inboundSharedBy <- map["inboundSharedBy"]
        self.noOfFiles <- map["noOfFiles"]
        self.fileLastModified <- map["fileLastModified"]
        self.maxPartNo <- map["maxPartNo"]
        self.fileUniqueID <- map["fileUniqueId"]
        self.sync <- map["sync"]
        self.versionNumber <- map["versionNumber"]
        self.tag <- map["tag"]
        self.flagImp <- map["flagImp"]
        self.browser <- map["browser"]
        self.isLocked <- map["isLocked"]
        self.lockedBy <- map["lockedBy"]
        self.toSign <- map["toSign"]
        self.folderIndex <- map["folderIndex"]
        self.fdIndex <- map["fdIndex"]
        self.fileIndex <- map["fileIndex"]
        self.dataURL <- map["dataURL"]
        self.fileCreatedLongTime <- map["fileCreatedLongTime"]
        self.fileModifiedLongTime <- map["fileModifiedLongTime"]
        self.folderPath <- map["folderPath"]
        self.folderPathLastChild <- map["folderPathLastChild"]
        self.dataRoomPath <- map["dataRoomPath"]
        self.bucketPathMD5 <- map["bucketPathMD5"]
        self.totalCount <- map["totalCount"]
        self.sourceUpload <- map["sourceUpload"]
        self.folderPermissions <- map["folderPermissions"]
        self.folderNM <- map["folderNM"]
        self.collaboraterName <- map["folderNM"]
        self.folderUserID <- map["folderUserID"]
        self.folderSize <- map["folderSize"]
        self.upload <- map["upload"]
    }
}

enum DataRoomPath {
    case unindex17Shared6E3C4B8Da87Fd81A97789Ee6F14A5Bc0
    case unindex1SharedA356A499Eb6F45033C9B04713Fe69Ba8
    case unindex6Shared717Ffc055E1E00965Ec973C6Aa2Fc5Eb
}

enum FileType {
    case docx
    case pdf
    case xlsx
}

enum Folder {
    case add5
    case add5BuildDrafthjhhghghghhh
    case add5Ducat
}

enum FolderType {
    case s
}

enum Status {
    case a
}
