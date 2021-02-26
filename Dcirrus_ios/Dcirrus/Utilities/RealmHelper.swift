//
//  RealmHelper.swift
//  Dcirrus
//
//  Created by Yobored on 20/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}


private let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: Config.groupName)!
    .appendingPathComponent("default.realm")

private let config = RealmConfig.getConfig(fileURL: fileURL)
let appRealm = try! Realm(configuration: config)

class RealmHelper {
    
    typealias Transaction = () -> Void
    private var uiRealm: Realm!
    
    class var shared : RealmHelper {
        struct Static {
            static let instance : RealmHelper = RealmHelper()
        }
        return Static.instance
    }
    
    
    
    func saveObjectToRealm(object: Object, update: Bool = true) {
        
        openTransaction {
            if update {
                uiRealm.add(object, update: .modified)
            } else {
                uiRealm.add(object)
            }
        }
    }
    
    func saveObjectToRealmSafely(object: Object, update: Bool = true) {
        
        try! uiRealm.safeWrite {
            if update {
                uiRealm.add(object, update: .modified)
            } else {
                uiRealm.add(object)
            }
        }
    }
    
    
    private func openTransaction(transaction: Transaction) {
        try! uiRealm.write {
            transaction()
        }
    }
}
