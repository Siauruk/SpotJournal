//
//  MainTableViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 4/29/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var spots: Results<Spot>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spots = realm.objects(Spot.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.isEmpty ? 0 : spots.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let spot = spots[indexPath.row]

        cell.nameLabel?.text = spot.name
        cell.locationLabel.text = spot.location
        cell.typeLabel.text = spot.type
        cell.imageOfSpot.image = UIImage(data: spot.imageData!)
        
        cell.imageOfSpot?.layer.cornerRadius = cell.imageOfSpot.frame.size.height / 2
        cell.imageOfSpot?.clipsToBounds = true

        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newSpotVC = segue.source as? NewSpotViewController else { return }
        
        newSpotVC.saveNewSpot()
        tableView.reloadData()
    }
}
