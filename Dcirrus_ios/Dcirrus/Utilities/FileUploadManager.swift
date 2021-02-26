//
//  FileUploadManager.swift
//  Dcirrus
//
//  Created by Yobored on 25/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

struct UploadData{
    var filePath: URL
    var fileName: String
    var fileSize: UInt64
    var upload: UnIndexDocumentList
}

class FileUploadManager {
    
    class var shared : FileUploadManager {
        struct Static {
            static let instance : FileUploadManager = FileUploadManager()
        }
        return Static.instance
    }
    var objData: UploadData!
    var uploadStatus: eFileUploadDownloadStatus = .notStarted
    var objCurrentUpload: UnIndexDocumentList!
    var uploadQueue = DispatchQueue(label: "com.goodbits.dcirrus.upload", qos: DispatchQoS.utility)
    
    var arrayOfUpload = Array<UploadData>()
    var progressBlock: ((Double?)->())?
    var sucessBlock: (()->Void)?
    var currentUpload: ((UnIndexDocumentList)->())?
    
    
    func startUpload(){
        uploadQueue.async {
            guard self.arrayOfUpload.count > 0 else {
                self.progressBlock = nil
                self.currentUpload = nil
                return
            }
            if self.uploadStatus == .notStarted {
                self.uploadStatus = .uploading
                self.objData = self.arrayOfUpload.removeFirst()
                self.objCurrentUpload = self.objData.upload
                self.currentUpload?(self.objCurrentUpload)
                self.getUploadURL(documentId: self.objCurrentUpload.folderID, documentName: self.objData.fileName, fileSize: self.objData.fileSize, objUpload: self.objCurrentUpload)
            }
        }
    }
    func upload(uploadURL: URL){
        AF.upload(objData.filePath, to: uploadURL).uploadProgress { (progress) in
            self.progressBlock?(progress.fractionCompleted)
        }.response { (responceData) in
            switch responceData.result {
            
            case .success(let responceData):
                if let data = responceData, let strFile = String(data: data, encoding: String.Encoding.utf8) {
                   print("File Upload AWS Responce", strFile)
                }
                self.updateUploadFileData(userId: objLogedInUser.objectD!.id, folderId: self.objCurrentUpload.folderID, parentFolderId: self.objCurrentUpload.parentFolderID, fileType: uploadURL.pathExtension, storageFileName: self.objData.fileName, fileSize: self.objData.fileSize)
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        }
    }
    
    
    func getUploadURL(documentId: Int,documentName: String,fileSize: UInt64,objUpload: UnIndexDocumentList){
        
        var parameter = Dictionary<String,Any>()
        
        var dicFileInfo = Dictionary<String,Any>()
        dicFileInfo["attribute1"] = documentId
        dicFileInfo["attribute2"] = documentName
        dicFileInfo["attribute3"] = fileSize
        
        parameter["listAttribute5"] = [dicFileInfo]
        parameter["attribute1"] = ""
        
        _ = APIManager.shared.requestPostJSON(url: eAppURL.getUploadURL, parameters: parameter, isShowIndicator: false, completionHandler: { (result) in
            switch result {
            case .success(let dic):
                if let fDic = dic as? Dictionary<String,Any>, let arrObj = fDic["object"] as? Array<Dictionary<String,Any>>,let firstObj = arrObj.first, let attribute3 = firstObj["attribute3"] as? String {
                    print("Upload URL :: ",attribute3)
                    if attribute3.isBlank == false , let url = URL(string: attribute3) {
                        self.upload(uploadURL: url)
                    }
                }
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    func updateUploadFileData(userId: Int,folderId: Int,parentFolderId: Int,fileType: String,storageFileName: String,fileSize: UInt64,status: String = "A",deleteStatus: String = "",fileUniqueId: String = "",folderType: String = "S",fileId: String = "0"){
        
        /*
         {
           "listAttribute4": [
             {
               "userId": "16",
               "folderId": "1093",
               "parentFolderId": "1093",
               "storageFileName": "SQL error.docx",
               "fileName": "SQL error.docx",
               "fileSize": 33402,
               "fileType": "docx",
               "status": "A",
               "deleteStatus": "",
               "folderType": "S",
               "fileUniqueId": "",
               "fileId": "0"
             }
           ],
           "boolAttribute1": false
         }
         */
        
        
        var parameter = Dictionary<String,Any>()
        
        var dicFileInfo = Dictionary<String,Any>()
        dicFileInfo["userId"] = userId
        dicFileInfo["folderId"] = folderId
        dicFileInfo["parentFolderId"] = parentFolderId
        dicFileInfo["storageFileName"] = storageFileName
        dicFileInfo["fileName"] = storageFileName
        dicFileInfo["fileSize"] = fileSize
        dicFileInfo["status"] = status
        dicFileInfo["fileType"] = fileType
        dicFileInfo["deleteStatus"] = deleteStatus
        dicFileInfo["folderType"] = folderType
        dicFileInfo["fileUniqueId"] = fileUniqueId
        dicFileInfo["fileId"] = fileId
        
        
        parameter["listAttribute4"] = [dicFileInfo]
        parameter["boolAttribute1"] = false
        
        _ = APIManager.shared.requestPostJSON(url: eAppURL.docAddMetaDataToServiceAfterUpload, parameters: parameter, isShowIndicator: false, completionHandler: { (result) in
            switch result {
            case .success(let dic):
                showInfoMessage(messsage: "File Uploaded Successfully")
                self.sucessBlock?()
                if self.arrayOfUpload.count > 0 {
                    self.uploadStatus = .notStarted
                    self.startUpload()
                }else {
                    self.uploadStatus = .notStarted
                }

            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    
    /**
     MessageCreator.getEncriptedData(data: data, aesKey: aesKey) { (encryptedData, err) in
     {
       listAttribute5: [
         {
           attribute1: "1093",
           attribute2: "1Doc1.pdf",
           attribute3: 46749
         }
       ],
       attribute1: ""
     }
     {
       listAttribute5: [
         {
           attribute1: Document id
           attribute2: file name
           attribute3: file size
         }
       ],
       attribute1: "" (blank in case of uploading single document)
     }
     */
}
