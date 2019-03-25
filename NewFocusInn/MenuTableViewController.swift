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
    var timelineHistory = [[String]]()
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ref = Database.database().reference()
        
        // timeline
        if segue.identifier == "timeline" {
            print("work")
            let vcNav = segue.destination as! UINavigationController
            let vc = vcNav.topViewController as! TimelineTableViewController
            
            if let user = Auth.auth().currentUser {
                ref!.child("timelineHistory").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    vc.timelineHistory = snapshot.value as! [[String]]
                })
                ref!.child("dates").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    vc.dates = snapshot.value as! [String]
                })
            }
        }
        
        // achievements
//        else if segue.identifier == "achievements" {
//            let vcNav = segue.destination as! UINavigationController
//            let vc = vcNav.topViewController as! AchievementsTableViewController
//
//            if let user = Auth.auth().currentUser {
//                ref?.child("hours").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                    vc.totalTime = snapshot.value as! Int
//                })
//                ref?.child("achievementList").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                    vc.achievements = snapshot.value as! [Int]
//                })
//            }
//        }
    }
}
