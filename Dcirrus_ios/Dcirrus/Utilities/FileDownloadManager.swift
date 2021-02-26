//
//  FileDownloadManager.swift
//  Dcirrus
//
//  Created by Yobored on 04/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper


struct DataOfDownloadFile{
    var document: UnIndexDocumentList
}


class FileDownloadManager {
    
    class var shared : FileDownloadManager {
        struct Static {
            static let instance : FileDownloadManager = FileDownloadManager()
        }
        return Static.instance
    }
    
    var downloadStatus: eFileUploadDownloadStatus = .notStarted
    var objCurrentDownload: UnIndexDocumentList!
    var downloadQueue = DispatchQueue(label: "com.goodbits.dcirrus.download", qos: DispatchQoS.utility)
    
    var arrayOfDownload = Array<DataOfDownloadFile>()
    var progressBlock: ((Double?)->())?
    var sucessBlock: ((URL)->())?
    var currentDownload: ((UnIndexDocumentList)->())?
    
    
    func startDownload(){
        downloadQueue.async {
            guard self.arrayOfDownload.count > 0 else {
                self.progressBlock = nil
                self.objCurrentDownload = nil
                return
            }
            if self.downloadStatus == .notStarted {
                self.downloadStatus = .downloading
                let objData = self.arrayOfDownload.removeFirst()
                self.objCurrentDownload = objData.document
                if self.objCurrentDownload.fileID != -1   {
                    var parameter = Dictionary<String,Any>()
                    parameter["attribute1"] = "\(self.objCurrentDownload.id)"
                    parameter["attribute2"] = Int(1)
                    parameter["attribute3"] = Int(1)
                    parameter["attribute4"] = Int(0)
                    parameter["boolAttribute1"] = false
/*
                    {
                    attribute1: "2163",
                    attribute2: 1,
                    attribute3: 1,
                    attribute4: 0,
                    boolAttribute1: false
                    }
*/
                    self.currentDownload?(self.objCurrentDownload)
                    AF.download(eAppURL.downloadFile.getURL(), method: HTTPMethod.post, parameters: parameter, encoding: JSONEncoding.default, headers: APIManager.shared.getHeader(), interceptor: nil) { (urlRequest) in
                        
                    } to: { (URL, HTTPURLResponse) -> (destinationURL: URL, options: DownloadRequest.Options) in
                        let fileName = "\(self.objCurrentDownload.folderID)_\(self.objCurrentDownload.fileName)"
                        var url = DirectoryManager.getTempDir(dirName: fileName)
                        print("Download Temp Path :: ",url)
                        if var urld = DirectoryManager.getDir(dirName: Constant.downloadedDocument) {
                            urld.appendPathComponent(fileName)
                            url = urld
                            print("Download Original Path :: ",url)
                        }
                        return (url,DownloadRequest.Options.removePreviousFile)
                    }.downloadProgress { progress in
                        print("Download Progress: \(progress.fractionCompleted)")
                        self.progressBlock?(progress.fractionCompleted)
                    }.cURLDescription { description in
                        print(description)
                    }.response { response in
                        debugPrint(response)
                        if response.error == nil, let path = response.fileURL{
                            self.sucessBlock?(path)
                        }
                        if self.arrayOfDownload.count > 0 {
                            self.downloadStatus = .notStarted
                            self.startDownload()
                        }else {
                            self.downloadStatus = .notStarted
                        }
                    }
                }
            }
        }
    }
}
