/*
LocalizationManager.swift
 Dcirrus

 Created by Yobored on 22/01/21.
 Copyright © 2021 Goodbits. All rights reserved.
*/

import Foundation
import UIKit

class LocalizationManager:NSObject {

    var bundle: Bundle!

    class var sharedInstance: LocalizationManager {
        struct Singleton {
            static let instance: LocalizationManager = LocalizationManager()
        }
        return Singleton.instance
    }

    override init() {
        super.init()
        bundle = Bundle.main
    }

    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }

    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }

    //MARK:- setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    func setLanguage(languageCode:String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat

        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }

    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }

    //MARK:- getLanguage
    // Just gets the current setted up language.
    func currentAppleLanguage() -> String {
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let prefferedLanguage = appleLanguages[0]
        if prefferedLanguage.contains("-") {
            let array = prefferedLanguage.components(separatedBy: "-")
            return array[0]
        }
        return prefferedLanguage
    }

}
class L012Localizer: NSObject {
    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector:
            #selector(Bundle.specialLocalizedString(key:value:table:)))
    }
}

extension Bundle {
    @objc func specialLocalizedString(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LocalizationManager.sharedInstance.currentAppleLanguage()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return (bundle.specialLocalizedString(key: key, value: value, table: tableName))
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector){

    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}


extension String {
   public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
