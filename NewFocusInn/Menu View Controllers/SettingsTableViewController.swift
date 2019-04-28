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
    @IBOutlet weak var sync: UIButton!
    var ref: DatabaseReference!
    
    @IBAction func outOfAccountSettings(unwindSegue: UIStoryboardSegue) {
        if Auth.auth().currentUser != nil {
            account.text = Auth.auth().currentUser?.displayName
            sync.isEnabled = true
            sync.titleLabel?.text = "Sync"
        }
        else {
            account.text = "Log In"
            sync.isEnabled = false
            sync.titleLabel?.text = ""
        }
    }
    @IBAction func syncing(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        if user != nil {
            self.ref = Database.database().reference().child("users").child(user!.uid)
            
            self.ref.child("houseList").setValue(houseList)
            self.ref.child("timelineHistory").setValue(timelineHistory)
            self.ref.child("dates").setValue(dates)
            self.ref.child("achievementList").setValue(achievements)
            self.ref.child("totalMinutes").setValue(totalTime)
            self.ref.child("sessions").setValue(sessions)
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
            sync.isEnabled = true
            sync.titleLabel?.text = "Sync"
        }
        else {
            account.text = "Log In"
            sync.isEnabled = false
            sync.titleLabel?.text = ""
        }
    }
}
