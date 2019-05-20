//
//  Session.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/19/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import Foundation

//  Session is an interface through which we access to UserDefaultsWrapper -> And then to UserDefaults store.
struct Session {
    
    static var isCompletedWelcomeScreen: Bool {
        get {
            return UserDefaultsWrapper.isCompletedWelcomeScreen
        }
        set {
            UserDefaultsWrapper.isCompletedWelcomeScreen = newValue
        }
    }
    
}
