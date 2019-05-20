//
//  WelcomeViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/19/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBAction func startButtonPressed() {
        finishWelcomeVC()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StorageManager.addDemoObjects()
    }
    
    
    private func finishWelcomeVC() {
        performSegue(withIdentifier: "startSegue", sender: nil)
        Session.isCompletedWelcomeScreen = true
    }

}
