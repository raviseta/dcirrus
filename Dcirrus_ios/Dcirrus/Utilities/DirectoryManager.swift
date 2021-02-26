//
//  DirectoryManager.swift
//  Dcirrus
//
//  Created by Yobored on 23/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
public class DirectoryManager {
    class func createDir(dirName: String) -> (Bool,String?,NSError?) {
        
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(dirName)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {//[FileAttributeKey.protectionKey:FileProtectionType.none]
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                    return  (true,filePath.absoluteString ,nil)
                } catch let error as NSError {
                    NSLog("Couldn't create document directory")
                    return (false,nil,error)
                }
            } else {
                return (false,nil,NSError(domain: "The directory exist", code: 12, userInfo: nil))
            }
        } else {
            return (false,nil,NSError(domain: "The directory exist", code: 12, userInfo: nil))
        }
    }
    
    class func getDir(dirName: String) -> URL? {
        
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return tDocumentDirectory.appendingPathComponent("\(dirName)")
        } else {
            return nil
        }
    }
    
    class func getListOfFiles(dirName: String) -> [URL]?{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let selectedDirectory = documentsURL.appendingPathComponent("\(dirName)")
        do {
            return try fileManager.contentsOfDirectory(at: selectedDirectory, includingPropertiesForKeys: nil)
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
            return nil
        }
    }
    class func getTempDir(dirName: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory().appending(dirName))
    }
    
    class func directoryExist(at filePath:String)->String?{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(filePath) {
            let filePath = pathComponent.path
            if FileManager.default.fileExists(atPath: filePath) {
                return filePath
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    class func listFilesFromDocumentsFolder(dirName: String) -> [URL]? {
        
        let fileManager = FileManager.default
        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath =  tDocumentDirectory.appendingPathComponent("\(dirName)")
        if fileManager.fileExists(atPath: filePath.path) == true {
            return try? fileManager.contentsOfDirectory(at: filePath.absoluteURL, includingPropertiesForKeys: nil, options: [])
        } else {
            return nil
        }
    }
    
    class func deleteFilesFromDocumentsFolder(dirName: String) -> Bool {
        
        let fileManager = FileManager.default
        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath =  tDocumentDirectory.appendingPathComponent("\(dirName)")
        if fileManager.fileExists(atPath: filePath.path) == true {
            do {
                try fileManager.removeItem(atPath: filePath.absoluteString)
                _ = DirectoryManager.createDir(dirName: dirName)
                return true
            }
            catch let error {
                print(error)
                _ = DirectoryManager.createDir(dirName: dirName)
                return false
            }
        } else {
            _ = DirectoryManager.createDir(dirName: dirName)
            return false
        }
    }
    
    class func deleteFilesFromURL(filePath: URL) -> Bool {
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath.path) == true {
            do {
                try fileManager.removeItem(at: filePath)
                return true
            }
            catch let error {
                print(error)
                return false
            }
        } else {
            return false
        }
    }
    class func deleteFile(filePath:URL) {
        print("Deleted File path::",filePath.absoluteString)
        guard FileManager.default.fileExists(atPath: filePath.path) else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
        }catch{
            // fatalError("Unable to delete file: \(error.localizedDescription).")
            print("Unable to delete file: \(error.localizedDescription).")
        }
    }
    class func deleteFileFromCache(filePath:URL)-> Bool {
        
        guard FileManager.default.fileExists(atPath: filePath.path) else {
            return false
        }
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
            return true
        }catch{
            print("Unable to delete file: \(error.localizedDescription).")
            return false
        }
    }
    
    class func fileExists(at filePath:URL) -> Bool {
        return FileManager.default.fileExists(atPath: filePath.path)
    }
    
    class func persist(data: Data, at url: URL) throws -> URL {
        do {
            try data.write(to: url, options: [.atomic])
            return url
        } catch let error {
            throw error
        }
    }
    
    
    class func generateTemporaryFilepath(strExtensionOfFile: String) -> URL {
        let currDateTime = Date().toMillis()
        let randomPath = "\(currDateTime).\(strExtensionOfFile)"
        return URL(fileURLWithPath: NSTemporaryDirectory().appending(randomPath))
    }
}
