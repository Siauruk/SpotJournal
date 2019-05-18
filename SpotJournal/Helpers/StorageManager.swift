//
//  StorageManager.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/6/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ spot: Spot) {
        try! realm.write {
            realm.add(spot)
        }
    }
    
    static func deleteObject(_ spot: Spot) {
        try! realm.write {
            realm.delete(spot)
        }
    }
}
