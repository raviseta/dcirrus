//
//  AppEnvironment.swift
//  Yoface
//
//  Created by Yobored on 03/03/20.
//  Copyright © 2020 yobored. All rights reserved.
//

import Foundation
import UIKit

enum eAppEnvironment {
    case development,
    production
}

class AppEnvironment {
    
    static let shared = AppEnvironment()
    var environmentType: eAppEnvironment = .development
    
    func setAppEnvironment(type: eAppEnvironment) {
        environmentType = type
    }
    
}
