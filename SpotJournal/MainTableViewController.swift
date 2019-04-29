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
        "Delmonico’s", "Rao’s", "Grand Central Oyster Bar & Restaurant",
        "Nathan's Famous", "Minetta Tavern", "The Odeon", "Bamonte’s",
        "21 Club", "John’s Pizzeria", "La Grenouille", "P.J. Clarke’s",
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

        return cell
    }
}
