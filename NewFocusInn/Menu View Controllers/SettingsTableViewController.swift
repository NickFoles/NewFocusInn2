//
//  SettingsTableViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var account: UILabel!
    
    @IBAction func outOfAccountSettings(unwindSegue: UIStoryboardSegue) {
        if Auth.auth().currentUser != nil {
            account.text = Auth.auth().currentUser?.displayName
        }
        else {
            account.text = "Log In"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // used to access the sidebar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.clearsSelectionOnViewWillAppear = false
        }
        
        if Auth.auth().currentUser != nil {
            account.text = Auth.auth().currentUser?.displayName
        }
        else {
            account.text = "Log In"
        }
    }
}
