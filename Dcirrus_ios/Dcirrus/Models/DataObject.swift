//
//  DataObject.swift
//  Dcirrus
//
//  Created by Yobored on 10/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

// MARK: - DataObject
class DataObject : Mappable {
    required init?(map: Map) {
        
    }
    
    var deleteType = eDeletedType.none
    
    /*
     "toSign": 0,
     "id": 0,
     "dataRoomPath": "",
     "folderPermissions": "Y#Y#Y#Y#Y#Y#Y",
     "folderIndex": "35",
     "fdIndex": "35",
     "collaboraterName": "",
     "fileModifiedLongTime": 0,
     "deleteStatus": "",
     "versionNumber": 1,
     "lockedBy": 0,
     "folderId": 889,
     "totalCount": 0,
     "isLocked": 0,
     "folderNM": "abcefgh",
     "tag": "",
     "fileType": "",
     "folderType": "S",
     "browser": "",
     "folderPath": "abcefgh",
     "fileName": "",
     "source": "",
     "flagImp": 0,
     "upload": false,
     "fileCreatedDate": "2020-07-06T19:34:50Z",
     "fileSize": 0,
     "status": "A",
     "sync": "",
     "folderPathLastChild": "abcefgh",
     "inboundSharedBy": "",
     "fileLastModified": "",
     "bucketPathMD5": "",
     "folderSize": 3885879,
     "folderUserId": 0,
     "parentFolderId": 0,
     "storageFileName": "",
     "fileModifiedDate": "2020-10-08T07:41:46Z",
     "dataURL": "",
     "fileCreatedLongTime": 0,
     "sourceUpload": "",
     "userId": 16,
     "fileIndex": ""
     */
    
    func mapping(map: Map) {
        self.noOfFiles <- map["noOfFiles"]
        self.maxPartNo <- map["maxPartNo"]
        self.fileID <- map["fileId"]
        self.fileUniqueID <- map["fileUniqueId"]
        self.toSign <- map["toSign"]
        self.id <- map["id"]
        self.dataRoomPath <- map["dataRoomPath"]
        self.folderPermissions <- map["folderPermissions"]
        self.folderIndex <- map["folderIndex"]
        self.fdIndex <- map["fdIndex"]
        self.collaboraterName <- map["collaboraterName"]
        self.fileModifiedLongTime <- map["fileModifiedLongTime"]
        self.deleteStatus <- map["deleteStatus"]
        self.versionNumber <- map["versionNumber"]
        self.lockedBy <- map["lockedBy"]
        self.folderID <- map["folderId"]
        self.totalCount <- map["totalCount"]
        self.isLocked <- map["isLocked"]
        self.folderNM <- map["folderNM"]
        self.tag <- map["tag"]
        self.fileType <- map["fileType"]
        self.folderType <- map["folderType"]
        self.browser <- map["browser"]
        self.folderPath <- map["folderPath"]
        self.fileName <- map["fileName"]
        self.source <- map["source"]
        self.flagImp <- map["flagImp"]
        self.upload <- map["upload"]
        self.fileCreatedDate <- map["fileCreatedDate"]
        self.fileSize <- map["fileSize"]
        self.status <- map["status"]
        self.sync <- map["sync"]
        self.folderPathLastChild <- map["folderPathLastChild"]
        self.inboundSharedBy <- map["inboundSharedBy"]
        self.fileLastModified <- map["fileLastModified"]
        self.bucketPathMD5 <- map["bucketPathMD5"]
        self.folderSize <- map["folderSize"]
        self.folderUserID <- map["folderUserId"]
        self.parentFolderID <- map["parentFolderId"]
        self.storageFileName <- map["storageFileName"]
        self.fileModifiedDate <- map["fileModifiedDate"]
        self.dataURL <- map["dataURL"]
        self.fileCreatedLongTime <- map["fileCreatedLongTime"]
        self.sourceUpload <- map["sourceUpload"]
        self.userID <- map["userId"]
        self.fileIndex <- map["fileIndex"]
    }
    var noOfFiles, maxPartNo, fileID: Int?
    var fileUniqueID: String?
    var toSign, id: Int?
    var dataRoomPath, folderPermissions, folderIndex, fdIndex: String?
    var collaboraterName: String?
    var fileModifiedLongTime: Int?
    var deleteStatus: String?
    var versionNumber, lockedBy, totalCount: Int?
    var folderID: Int = 0
    var isLocked: Int?
    var folderNM, tag, fileType, folderType: String?
    var browser, folderPath, fileName, source: String?
    var flagImp: Int?
    var upload: Bool?
    var fileCreatedDate: Date?
    var fileSize: Int?
    var status, sync, folderPathLastChild, inboundSharedBy: String?
    var fileLastModified, bucketPathMD5: String?
    var folderSize, folderUserID, parentFolderID: Int?
    var storageFileName: String?
    var fileModifiedDate: Date?
    var dataURL: String?
    var fileCreatedLongTime: Int?
    var sourceUpload: String?
    var userID: Int?
    var fileIndex: String?

    init(noOfFiles: Int?, maxPartNo: Int?, fileID: Int?, fileUniqueID: String?, toSign: Int?, id: Int?, dataRoomPath: String?, folderPermissions: String?, folderIndex: String?, fdIndex: String?, collaboraterName: String?, fileModifiedLongTime: Int?, deleteStatus: String?, versionNumber: Int?, lockedBy: Int?, folderID: Int?, totalCount: Int?, isLocked: Int?, folderNM: String?, tag: String?, fileType: String?, folderType: String?, browser: String?, folderPath: String?, fileName: String?, source: String?, flagImp: Int?, upload: Bool?, fileCreatedDate: Date?, fileSize: Int?, status: String?, sync: String?, folderPathLastChild: String?, inboundSharedBy: String?, fileLastModified: String?, bucketPathMD5: String?, folderSize: Int?, folderUserID: Int?, parentFolderID: Int?, storageFileName: String?, fileModifiedDate: Date?, dataURL: String?, fileCreatedLongTime: Int?, sourceUpload: String?, userID: Int?, fileIndex: String?) {
        self.noOfFiles = noOfFiles
        self.maxPartNo = maxPartNo
        self.fileID = fileID
        self.fileUniqueID = fileUniqueID
        self.toSign = toSign
        self.id = id
        self.dataRoomPath = dataRoomPath
        self.folderPermissions = folderPermissions
        self.folderIndex = folderIndex
        self.fdIndex = fdIndex
        self.collaboraterName = collaboraterName
        self.fileModifiedLongTime = fileModifiedLongTime
        self.deleteStatus = deleteStatus
        self.versionNumber = versionNumber
        self.lockedBy = lockedBy
        self.folderID = folderID ?? 0
        self.totalCount = totalCount
        self.isLocked = isLocked
        self.folderNM = folderNM
        self.tag = tag
        self.fileType = fileType
        self.folderType = folderType
        self.browser = browser
        self.folderPath = folderPath
        self.fileName = fileName
        self.source = source
        self.flagImp = flagImp
        self.upload = upload
        self.fileCreatedDate = fileCreatedDate
        self.fileSize = fileSize
        self.status = status
        self.sync = sync
        self.folderPathLastChild = folderPathLastChild
        self.inboundSharedBy = inboundSharedBy
        self.fileLastModified = fileLastModified
        self.bucketPathMD5 = bucketPathMD5
        self.folderSize = folderSize
        self.folderUserID = folderUserID
        self.parentFolderID = parentFolderID
        self.storageFileName = storageFileName
        self.fileModifiedDate = fileModifiedDate
        self.dataURL = dataURL
        self.fileCreatedLongTime = fileCreatedLongTime
        self.sourceUpload = sourceUpload
        self.userID = userID
        self.fileIndex = fileIndex
    }
}
