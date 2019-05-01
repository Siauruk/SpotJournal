//
//  NewSpotViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class NewSpotViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
    
    
}


// MARK: Text field delegate

extension NewSpotViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
