//
//  UserDefaultsWrapper.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/19/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import Foundation

//  UserDefaultsWrapper helps to read and write to UserDefaults store with a key.
struct UserDefaultsWrapper {
    
    private static let UserDefaultsStandart = UserDefaults.standard
    
    static var isCompletedWelcomeScreen: Bool {
        get {
            return UserDefaultsStandart.bool(forKey: PersistantKeys.isCompletedWelcomeScreen)
        }
        set {
            UserDefaultsStandart.set(newValue, forKey: PersistantKeys.isCompletedWelcomeScreen)
            UserDefaultsStandart.synchronize()
        }
    }
    
    private enum PersistantKeys {
        static let isCompletedWelcomeScreen = "kisCompletedWelcomeScreen"
    }
}
