//
//  SpotModel.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import Foundation

struct Spot {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let tempRestaurantNames = [
        "Katz’s Delicatessen", "Peter Luger", "Lombardi’s",
        "Keens Steakhouse", "Junior’s Restaurant", "Tavern on the Green",
        "The Rainbow Room", "Totonno's", "The Russian Tea Room",
        "Delmonico’s", "Rao’s", "P.J. Clarke’s", "La Grenouille",
        "Nathan's Famous", "Minetta Tavern", "The Odeon", "Bamonte’s",
        "21 Club", "John’s Pizzeria"
    ]
    
    static func getSpots() -> [Spot] {
        
        var spots = [Spot]()
        
        for spot in tempRestaurantNames {
            spots.append(Spot(name: spot, location: "New York", type: "Restaurant", image: spot))
        }
        
        return spots
    }
}
