//
//  LocalStore.swift
//  DesignerNewsApp
//
//  Created by André Schneider on 30.01.15.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import UIKit

struct LocalStore {

    private static let userDefaults = NSUserDefaults.standardUserDefaults()

    static func setIntroAsVisited() {
        userDefaults.setObject(true, forKey: "introKey")
    }
    
    static func isIntroVisited() -> Bool {
        return userDefaults.boolForKey("introKey")
    }

}
