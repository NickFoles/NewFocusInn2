//
//  MenuTableViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MenuTableViewController: UITableViewController {
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
    }
}
