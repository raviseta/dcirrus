//
//  AppConstants.swift
//  Dcirrus
//
//  Created by raviseta on 28/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    static var token = ""

}


var objLogedInUser: LoginResponse!

struct Preference {
    static var token = "perToken"
    static var logedInUser = "logedInUser"
}

struct Constant {
    static var downloadedDocument = "downloadedDocument"
    static var applicationName = "Dcirrus"
}


//MARK:- Set/Get/RemoceValueFromPreference
func setValueInPreference(suiteName: String? = nil,forKey: String, value: Any) {
    if let userDefault = UserDefaults(suiteName: suiteName) {
        userDefault.set(value, forKey: forKey)
        userDefault.synchronize()
    }
}

func getValueFromPreference(suiteName: String? = nil,forKey: String) -> Any? {
    if let userDefault = UserDefaults(suiteName: suiteName),let prefValue = userDefault.value(forKey: forKey) {
        return prefValue
    }
    return nil
}

func removeValueFromPreference(suiteName: String? = nil,forKey: String) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
        if let userDefault = UserDefaults(suiteName: nil) {
            userDefault.removeObject(forKey: forKey)
            userDefault.synchronize()
        }
    }
}


