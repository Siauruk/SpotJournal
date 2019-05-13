//
//  CustomTableViewCell.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfSpot: UIImageView! {
        didSet {
            imageOfSpot?.layer.cornerRadius = imageOfSpot.frame.size.height / 2
            imageOfSpot?.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet var ratingView: RatingView!
    
}
