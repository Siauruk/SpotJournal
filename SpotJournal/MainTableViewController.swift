//
//  MainTableViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 4/29/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let spots = Spot.getSpots()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel?.text = spots[indexPath.row].name
        cell.locationLabel.text = spots[indexPath.row].location
        cell.typeLabel.text = spots[indexPath.row].type
        cell.imageOfSpot?.image = UIImage(named: spots[indexPath.row].image)
        cell.imageOfSpot?.layer.cornerRadius = cell.imageOfSpot.frame.size.height / 2
        cell.imageOfSpot?.clipsToBounds = true

        return cell
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        
    }
}
