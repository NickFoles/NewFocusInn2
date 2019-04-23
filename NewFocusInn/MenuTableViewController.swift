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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let user = Auth.auth().currentUser {
//            ref = Database.database().reference().child("users").child(user.uid)
//        
//            // timeline
//            if segue.identifier == "timeline" {
//                print("work")
//                
//                ref!.child("timelineHistory").observeSingleEvent(of: .value, with: { (snapshot) in
//                    timelineHistory = snapshot.value as! [[String]]
//                })
//                ref!.child("dates").observeSingleEvent(of: .value, with: { (snapshot) in
//                    dates = snapshot.value as! [String]
//                })
//            }
//        
//            // achievements
//            else if segue.identifier == "achievements" {
//                
//                ref?.child("hours").observeSingleEvent(of: .value, with: { (snapshot) in
//                    totalTime = snapshot.value as! Int
//                })
//                ref?.child("achievementList").observeSingleEvent(of: .value, with: { (snapshot) in
//                    achievements = snapshot.value as! [Int]
//                })
//            }
//        }
//    }
}
