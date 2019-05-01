//
//  MainTableViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 4/29/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let tempRestaurantNames = [
        "Katz’s Delicatessen", "Peter Luger", "Lombardi’s",
        "Keens Steakhouse", "Junior’s Restaurant", "Tavern on the Green",
        "The Rainbow Room", "Totonno's", "The Russian Tea Room",
        "Delmonico’s", "Rao’s", "P.J. Clarke’s", "La Grenouille",
        "Nathan's Famous", "Minetta Tavern", "The Odeon", "Bamonte’s",
        "21 Club", "John’s Pizzeria"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempRestaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tempRestaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: tempRestaurantNames[indexPath.row])
        cell.imageView?.layer.cornerRadius = cell.frame.height / 2
        cell.imageView?.clipsToBounds = true

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
