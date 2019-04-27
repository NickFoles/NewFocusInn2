//
//  FirebaseViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseViewController: UIViewController {
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // takes the user to their account homescreen if they are already logged in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // accesses database info from user's account
    @IBAction func firebaseHome(unwindSegue: UIStoryboardSegue) {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            ref = Database.database().reference().child("users").child(user!.uid)
            
            // list of buildings corresponding to city coordinates and sessions
            ref!.child("houseList").observeSingleEvent(of: .value, with: { (snapshot) in
                houseList  = snapshot.value as! [String]
            })
            ref?.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
                sessions = snapshot.value as! Int
            })
            
            // timeline history and dates
            ref!.child("timelineHistory").observeSingleEvent(of: .value, with: { (snapshot) in
                timelineHistory = snapshot.value as! [[String]]
            })
            ref!.child("dates").observeSingleEvent(of: .value, with: { (snapshot) in
                dates = snapshot.value as! [String]
            })
            
            // achievements and total focusing time
            ref?.child("totalMinutes").observeSingleEvent(of: .value, with: { (snapshot) in
                totalTime = snapshot.value as! Int
            })
            ref?.child("achievementList").observeSingleEvent(of: .value, with: { (snapshot) in
                achievements = snapshot.value as! [Int]
            })
        }
    }

}
