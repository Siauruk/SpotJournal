//
//  MainViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 4/29/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var spots: Results<Spot>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spots = realm.objects(Spot.self)
    }

    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.isEmpty ? 0 : spots.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let spot = spots[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deleteObject(spot)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let spot = spots[indexPath.row]
            let newSpotVC = segue.destination as! NewSpotViewController
            newSpotVC.currentSpot = spot
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newSpotVC = segue.source as? NewSpotViewController else { return }
        
        newSpotVC.saveSpot()
        tableView.reloadData()
    }
}
