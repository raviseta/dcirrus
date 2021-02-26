//
//  APIConstant.swift
//  Yoface
//
//  Created by Yobored on 05/03/20.
//  Copyright © 2020 yobored. All rights reserved.
//

import Foundation
import UIKit

//MARK:- APPLICATION_MESSAGE
struct AppMessage {
    
    //Permisssion Not allowed message
    static let MsgPermissionCameraTitle = "Use  Yoface's Camera"
    static let MsgPermissionCameraSubTitle = "Enable permission to record videos."
    
    static let MsgPermissionContact = "Access to Contacts"
    static let MsgPermissionContactSubTitle = "Allow Yoface access to Contacts to seamlessly find all your friends."
     static let MsgNoContact = "No Contacts in Address book"
    
   
    
    static let MsgMessage              = "Message"
    static let MsgNoInternet           = "The Internet connection appears to be offline"
    static let MsgProblemInLoading     = "Problem in loading data\nPlease try again"
    static let MsgNoData               = "No record found\nPlease try again"
    static let MsgLogout               = "Are you sure you want to logout?"
    static let MsgClearNotification    = "Are you sure you want to delete all notifications?"
    static let MsgPrivateAccount       = "This account is private"
    static let MsgReportUser           = "Are you sure you want to report this user?"
    static let MsgBlockUser            = "Are you sure you want to block this user?  You will never see this user's content again."
    static let MsgClearAllChat   = "Are you sure you want to clear all conversation?"
    
    
    static let MsgUnblockUser = "Are you sure you want to reset all previous blocked users? You might see content you may not like."
    
    static let MsgAchievementGoal      = "Goal Achieved!"
    static let MsgAchievementFirstPost = "Congratulations!  You're alive."//"Post for the first time."
    static let MsgAchievementWelcome   = "Welcome!"
    static let MsgAchievementWelcomeMsg = "Successfully joined Yobored!"
    
    //Chat
    static let MsgKickOutMember         = "Are you sure you want to kick out"
    
    //EmptyStateMessages
    static let MsgEmptyNotification     = "You're all up to date."
    static let MsgEmptyProfileMedia     = "You haven't aired yet."
    static let MsgEmptyProfileVault     = "Nothing in your vault yet."
    static let MsgEmptyStats            = "You have not aired any episodes."
    static let MsgEmptyFeed            = "There are no episodes here yet."
    static let MsgEmptyFeedSearch      = "No Search results found"
    static let MsgEmptyTopics          = "No topics here"
    static let MsgEmptyLocation        = "No places here"
    static let MsgEmptyHastag        = "No hashtags here"
    static let MsgEmptyRecentChat       = "It's nice to text with someone"
    
    
    
    static let MsgDeleteAccountMessage = "Are you sure you want to delete account? Your account and videos will be deleted!"
    static let MsgDeleteAccountRecovery = "Your account will be permanently deleted in 30 days, if you want to restore your account just login within 30 days! Yobored will miss you and would be glad to have you back!"
    
    
    static let MsgAccoutRecovery = "Warning! You have not set up recovery. If you forget your password you may not be able to restore your account. Would you like to set up account recovery at this time?"
    
    static let MsgShareYoboredURL = "I'm inviting you to Yobored - Stories around the world. Download it for free!\n\nhttps://www.yobored.com/dl"
    static let MsgQuote: String = "Stories around the world."
    
    static let MsgTermsAndCondition: String = "Welcome to Yoface! Connect with people. It's about people, culture, and awareness. Have fun!" + "\n" + "By continuing to use the application you agree to the Yoface Terms and Conditions and Privacy Policies."

    //error message
    static let ErrEnterA: String = "Enter your alias"
    static let strQuote: String = "Stories around the world."
    static let shareYoboredURL = "Check out Yobored. I use it to share stories with the world, discover places, and see new content worldwide! Get it for free at" + "\n" + "https://www.yobored.com/dl"
}

//MARK:- API_KEYS
struct APIKey {
    
    //Static Keys
    static let XAPI         = "x-api-key"
    static let XAPIValue    = "Zjc2MDQ0MmExNDg5NDgzNzE386nux08D52wO7uTfE32TypyzZaueDYTaGUz"
    static let AccessToken  = "access_token"
    static let Data         = "data"
    static let Message      = "message"
    static let messageCode = "messageCode"
    static let code          = "code" 
    static let UserInfo     = "userInfo"
    static let version = "app-version"
    //Keys
    static let DeviceToken   = "device_token"
    static let DeviceType    = "device_type"
    static let PagePerItem   = "pagePerItem"
    static let isLoginYoface = "is_login_yoface"
    
    //User
    static let UserID       = "user_id"
    static let Username     = "username"
    static let Email        = "email"
    static let Password     = "password"
    static let fanClubCount = "fan_club_count"
    static let isFan        = "is_fan"
    static let CountryCode  = "country_code"
    
    static let OTP          = "otp"
    static let Phone        = "phone"
    static let ProfilePic   = "image"
    static let FirstName    = "firstname"
    static let LastName     = "lastname"
    static let BirthDate    = "birth_date"
    static let Latitude     = "latitude"
    static let Longitude    = "longitude"
    static let BuildVersion = "build_version"
    static let Contacts     = "contacts"
    static let CompositeID  = "composite_id"
    static let YoCount      = "count"
    static let PageNumber   = "page"
    static let XPPoints     = "points"
    static let FirebaseToken = "firebase_token"
    static let PushKitToken = "sns_token"
    static let ProfilePrimaryColor      = "profile_primary_color"
    static let ProfileSecondaryColor    = "profile_secondary_color"
    static let isTwoStepAuth = "isTwoStepAuth"
    
    static let Page = "page"
    static let referralUserID = "referral_user_id"
    
    //Channel
    static let ChannelId = "channel_id"
    static let Address = "address"
    static let Description = "description"
    static let IsEarth = "is_earth"
    static let Search = "search"
    
    //Feed
    static let Feedtype =  "type"
    static let FeedID   =  "feed_id"
    static let FeedTimeZone   = "timezone"
    
}



struct APIConstants {
      
    static var isShowLog: Bool = true
    
    static let isDebug:Bool = true    //"true" - Staging & "false" - Live
    static var ProductionURL = "https://dcirrus.io"
    static var TestURL = "https://dcirrus.co.in"
    
    static let DEVICE_FULLNAME: String = "\(UIDevice.current.name)"
    static let DEVICE_OS: String  = UIDevice.current.systemVersion
    static var DEVICEUDID: String  = "" // Updated from APpDelegate
    
    //MARK://******* WS METHOD LIST
    static let WS_LOGIN: String = "/api.acms/v1/publicapi/login/0/atc"
    static let WS_CHANGEPASSWORD: String = "/api.acms/v1/publicapi/changepassword/0/atc"
    static let WS_TIMESTAMPSERVERURL: String = "/api.acms/v1/publicapi/gettime/0/atc"
    static let WS_VERIFYDEVICESERVERURL: String = "/api.acms/v1/publicapi/verifydevice/0/<LAWFIRMID>/<USERID>/<DEVICEID>/atc"
    static let WS_FORGOTPASSURL: String = "/api.acms/v1/public/forgotpass/0/<LAWFIRMNUMBER>/<DEVICEID>/<DEVICETYPE>/<LOGINID>/atc"
    
}
