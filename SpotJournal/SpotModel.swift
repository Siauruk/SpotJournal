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
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()  
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
    
}


