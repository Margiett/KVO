//
//  Settings.swift
//  KVO
//
//  Created by Margiett Gil on 4/9/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

// Settings needs to be KVO-compliant
@objc
class Settings: NSObject {
    static var shared = Settings()
    @objc dynamic var fontSize: Int // property marked for observing
    @objc dynamic var iconName: String // property marked for observing 
    override private init() {
        fontSize = 17
        iconName = "sun.haze.gill"
    }
}
