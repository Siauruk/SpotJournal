//
//  SpotModel.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import RealmSwift

class Spot: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    let tempSpotNames = [
        "Katz’s Delicatessen", "Peter Luger", "Lombardi’s",
        "Keens Steakhouse", "Junior’s Restaurant", "Tavern on the Green",
        "The Rainbow Room", "Totonno's", "The Russian Tea Room",
        "Delmonico’s", "Rao’s", "P.J. Clarke’s", "La Grenouille",
        "Nathan's Famous", "Minetta Tavern", "The Odeon", "Bamonte’s",
        "21 Club", "John’s Pizzeria"
    ]
    
    func saveSpots() {

        for spot in tempSpotNames {
            
            let image = UIImage(named: spot)
            guard let imageData = image?.pngData() else { return }
            
            let newSpot = Spot()
            
            newSpot.name = spot
            newSpot.location = "New York"
            newSpot.type = "Restaurant"
            newSpot.imageData = imageData
            
            StorageManager.saveObject(newSpot)
        }
    }
    
}


