//
//  AchievementsTableViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AchievementsTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    
    var ref: DatabaseReference!
    var achievements: [Int] = [0,0,0,0,0]
    var totalTime : Int = 10
    
    var achList : [String] = [""]
//                              ["Marathon - Study for 2 hours straight",
//                              "Workaholic - Study for 10 hours in total",
//                              "Freshmen - Complete 1 study session",
//                              "Veteran - Complete 10 study sessions",
//                              "Senioritis - Complete 100 study sessions"]

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        ref = Database.database().reference()
        if let user = Auth.auth().currentUser {
            ref?.child("achievementList").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.achievements = snapshot.value as! [Int]
            })
            
        }
        if let user = Auth.auth().currentUser {
            ref?.child("hours").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.totalTime = snapshot.value as! Int
            })
            
        }
        
        checkAchievements()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return achList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let tableViewCell = UITableViewCell()
        if let user = Auth.auth().currentUser{
            if achList.count > 0{
                tableViewCell.textLabel?.font = UIFont(name: "helvetica neue", size: 15)
                tableViewCell.textLabel?.textAlignment = .center
                print(indexPath.row)
                tableViewCell.textLabel?.text = achList[indexPath.row]
            }
        }
        return tableViewCell
    }
 
    
    func checkAchievements(){
        if totalTime >= 10{
            achList.append("Workaholic - Study for 10 hours in total")
        }
        achievements[1] = 1
        if let user = Auth.auth().currentUser {
            ref?.child("achievementList").child(user.uid).setValue(achievements)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
