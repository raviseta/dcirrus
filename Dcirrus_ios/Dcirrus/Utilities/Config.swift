//
//  Config.swift
//  Dcirrus
//
//  Created by Yobored on 20/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit

class Colors {

    static let typingAndRecordingColors = "#0080D4".toColor
    static let notTypingColor = UIColor.darkGray

    static let circularStatusUserColor = "#D81B60".toColor
    static let circularStatusSeenColor = UIColor.lightGray

    static let circularStatusNotSeenColor = UIColor.red

    static let voiceMessageSeenColor = UIColor.blue
    static let voiceMessageNotSeenColor = UIColor.gray

    static let chatsListIconColor = UIColor.gray

    //the default colors for read tags(pending,sent,received) in ChatVC
    static let readTagsDefaultChatViewColor = "#507f48".toColor

    static let readTagsPendingColor = UIColor.gray
    static let readTagsSentColor = UIColor.gray
    static let readTagsReceivedColor = UIColor.gray
    static let readTagsReadColor = "#FF5722".toColor

    static let replySentMsgAuthorTextColor = "#20b66e".toColor
    static let replySentMsgBackgroundColor = "#f7ffef".toColor
    static let sentMsgBgColor = "#b5ff94".toColor


    static let replyReceivedMsgAuthorTextColor = "#0080D4".toColor
    static let replyReceivedMsgBackgroundColor = "#f1f1f1".toColor
    static let receivedMsgBgColor = UIColor.white

    static let highlightMessageColor = UIColor.yellow


}

class TextStatusColors {
    public static let colors = [
        "#FF8A8C",
        "#54C265",
        "#8294CA",
        "#A62C71",
        "#90A841",
        "#C1A03F",
        "#792138",
        "#AE8774",
        "#F0B330",
        "#B6B327",
        "#C69FCC",
        "#8B6990",
        "#26C4DC",
        "#57C9FF",
        "#74676A",
        "#5696FF"
    ]
}


class Config {
    
    static let appName = "Dcirrus"
    
    
    static let bundleName = "com.goodbits.Dcirrus"
    static let groupName = "group.\(bundleName)"
    private static let teamId = ""
    
    private static let shareURLScheme = ""
    static let shareUrl = "\(shareURLScheme)://dataUrl=Share"
    static let groupHostLink = ""
    
    private static let appId = ""// you can get it from AppStore Connect
    static let appLink = "https://apps.apple.com/app/id\(appId)"
    static let sharedKeychainName = "\(teamId).\(bundleName).\(groupName)"
    static let privacyPolicyLink = ""
    
    
    
    //About
    static let twitter = ""
    static let website = ""
    static let email = ""
    
}



fileprivate extension String {

    var toColor: UIColor {
        var cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
