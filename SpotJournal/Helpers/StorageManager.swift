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


extension StorageManager {
    
    static func addDemoObjects() {

            let rawData1 = UIImage(named: "The Chicken or the Egg")?.pngData()
            let rawData2 = UIImage(named: "Musashino Sushi Dokoro")?.pngData()
            let rawData3 = UIImage(named: "Central Park New York")?.pngData()
            
            let spot1 = Spot(name: "The Chicken or the Egg", location: "207 N Bay Ave, Beach Haven, NJ 08008, USA", type: "American Restaurant", imageData: rawData1, rating: 4)
            let spot2 = Spot(name: "Musashino Sushi Dokoro", location: "2905 San Gabriel St #200 Austin, TX 78705", type: "Sushi", imageData: rawData2, rating: 4)
            let spot3 = Spot(name: "Central Park New York", location: "Central Park New York", type: "Park", imageData: rawData3, rating: 5)
            
            saveObject(spot1)
            saveObject(spot2)
            saveObject(spot3)
    }
    
}
