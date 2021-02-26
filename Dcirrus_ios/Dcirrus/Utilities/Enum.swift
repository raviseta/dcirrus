//
//  Enum.swift
//  Dcirrus
//
//  Created by raviseta on 18/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation

enum eInfoMessageType: Int {
    case success = 1,
    error
}

enum errorMessage : String{
    case login_messages_userapprovalrequest = "Your request to access this account has been forwarded to your corporate admin. Please contact your corporate administrator"
    case login_messages_corporateExpired = "Data Room subscription has expired."
    case login_messages_corporateExpiredUser = "Access to the corporate has been expired. To get access, please contact your administrator"
    case login_messages_deviceblockedexceedloginIndividual = "You have exceeded the maximum no of attempts to login. Your account has been blocked. Please do forgot password to access your account again"
    case login_messages_deviceblocked = "Your device is no longer accessible. Please contact your administrator"
    case login_messages_deviceblockedbyuser = "Your device is no longer accessible. You can do forgot password to unblock your device."
    case login_messages_invalidip = "The IP address you are logging from is not approved. Please contact your administrator"
    case login_messages_userblocked = "This account has been blocked. Please contact your corporate administrator"
    case login_messages_userfirstblocked = "Your account has been blocked. Please do forgot password to access your account again."
    case login_messages_captchamismatch = "Captcha mismatch"
    case login_messages_invalidcredentials = "Please enter valid credentials"
    case login_messages_OTPmismatch = "OTP expired or OTP entered is wrong. Please try again."
    case login_messages_corpsetupincomplete = "Data room setup not complete yet. Please contact your system administrator."
    case login_messages_genericmessage = "Unexpected error occur. Please contact your system administrator."
    case login_messages_deviceblockedexceedloginBussiness = "You have exceeded the maximum no of attempts to login. This device has been blocked. You can do forgot password to unblock your device."
}

enum eFileType : String  {
    case pdf = "pdf"
    case xlsx = "xlsx"
    case docx = "docx"

}

enum eSwipeOption : String {
    case rename = "Rename"
    case share = "Share"
    case permission = "Permission"
    case download = "Download"
    case delete = "Delete"
    case restore = "Restore"
}

enum ePopupType {
    case folderCreate
    case fileCreate
    case renameFolder
}

enum eShareOptionState {
    case checked
    case unchecked
}

enum eDeletedType {
    case none
    case soft
    case permanent
}
enum eFileUploadDownloadStatus {

    case notStarted
    case uploading
    case downloading
    case pause
    case uploaded
    case downloaded

}
