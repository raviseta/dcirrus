//
//  AppURL.swift
//  Yoface
//
//  Created by Yobored on 03/03/20.
//  Copyright © 2020 yobored. All rights reserved.
//

import Foundation

let APIVersion: String = "v1"
var isShowLog: Bool = true
var folderID: String = "0"
var folderIDForDeletion: String = "0"
var dateAndTimeForShare: String = "8-2-2021 14:54:32" //dd-m-yyyy hh:mm:ss "8-2-2021 14:54:32"
var maxLimit: String = "10"

enum eAppBaseURL: String {
    
    
    case baseURLLive = "http://dcirrus.co.in/api.acms/v1/"
    case baseURLTesting = "http://13.90.46.216:8080/api.acms/v1/"
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .development:
            return eAppBaseURL.baseURLTesting.rawValue
        case .production:
            return eAppBaseURL.baseURLLive.rawValue
        }
    }
}

enum eAppURL {
    case login
    case fetchAllAdmFolderListResponse
    case admSingleUserProfileServiceAfter
    case admFetchStorageLeftServiceAfter
    case admOTPSettingsServiceAfter
    case fetchAllAdmFolderChildListResponse
    case admRenameNewFolderServiceAfter
    case admDeleteFolderServiceAfter
    case admDownloadFolderServiceAfter
    case admInboundShareURLsServiceAfter
    case admShareURLsServiceAfter
    case deleteFolder
    case downloadFile
    case restoreTrashedDocsAfter
    case getUploadURL
    case docAddMetaDataToServiceAfterUpload
    func getURL() -> String {
        let baseURL = eAppBaseURL.getBaseURL()
        
        switch self {
        
        case .login:
            return baseURL + "publicapi/login/0/loginsuccess"
        case .fetchAllAdmFolderListResponse :
            return baseURL + "app/unindexfolderlistg/0/zerolevel/0/S/fetchAllAdmFolderListResponse"
        case .admSingleUserProfileServiceAfter:
            return baseURL + "app/user/0/list/379/3/admSingleUserProfileServiceAfter"
        case .admFetchStorageLeftServiceAfter:
            return baseURL + "app/fetchstoragespace/0/admFetchStorageLeftServiceAfter"
        case .admOTPSettingsServiceAfter:
            return baseURL + "app/ots/0/fts/0/379/admOTPSettingsServiceAfter"
        case .fetchAllAdmFolderChildListResponse:
            return baseURL + "app/unindexdoclist/0/\(maxLimit)/\(folderID)/DESC%60lastmodified/fetchAllAdmFolderChildListResponse"
        case .admRenameNewFolderServiceAfter:
            return baseURL + "app/unindexdocfolderrename/0/admRenameNewFolderServiceAfter"
        case .admDeleteFolderServiceAfter:
            return baseURL + "app/unindexfolderdeleteg/0/\(folderIDForDeletion)/admDeleteFolderServiceAfter"
        case .admDownloadFolderServiceAfter:
            return  baseURL + "app/unindexdocdownload/0/zipfolder/\(folderID)/admDownloadFolderServiceAfter"
        case .admInboundShareURLsServiceAfter:
            return baseURL + "app/unindexotpadd/0/admInboundShareURLsServiceAfter"
        case .admShareURLsServiceAfter:
            return baseURL + "app/unindexdocshare/0/\(dateAndTimeForShare)/admShareURLsServiceAfter".urlQuery
        case .deleteFolder:
            return baseURL + "app/unindexfolderdeleteg/0/\(folderID)/admDeleteFolderServiceAfter"
        case .downloadFile:
            return baseURL + "app/unindexdocdownload/0/zip/admDownloadZipFileAfter"
        //https://dcirrus.co.in/api.acms/v1/app/unindexdocdownload/0/zip/admDownloadZipFileAfter"
        case .restoreTrashedDocsAfter:
            return baseURL + "app/unindexdocrestorelist/0/admrestoreTrashedDocsAfter"
        //URL:  api.acms/v1/app/unindexdocrestorelist/0/admrestoreTrashedDocsAfter
        
        case .getUploadURL:
            return baseURL + "app/unindexgend/0/atc"
        //api.acms/v1/app/unindexgend/0/atc
        case .docAddMetaDataToServiceAfterUpload:
            return baseURL + "app/unindexdocadd/0/desktop/admDocAddMetaDataServiceAfter"
    
        //api.acms/v1/app/unindexdocadd/0/desktop/admDocAddMetaDataServiceAfter
        
        }
        
    }
}
