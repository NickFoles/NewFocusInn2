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

var achievements = [Int]()
var totalTime = 0
var sessions = 0

// Use to set time and Date when completed achievement
extension Date {
    var weekdayNameAndDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E/MMM d"
        return formatter.string(from: self as Date)
    }
    
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self as Date)
    }
}

class AchievementsTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    let achList = [["Freshmen","Complete 10 study session"], ["Veteran", "Complete 25 study sessions"], ["Senioritis", "Complete 50 study sessions"], ["Workaholic", "Total focus time reaches 10 hours"]]
//                              ["Marathon - Study for 2 hours straight",
//                              "Workaholic - Study for 10 hours in total",
//                              "Freshmen - Complete 1 study session",
//                              "Veteran - Complete 10 study sessions",
//                              "Senioritis - Complete 100 study sessions"]
    let badges = ["10 buildings", "25 buildings", "50 buildings", "workaholic"]
    let grayScale = ["10 buildings gray", "25 buildings gray", "50 buildings gray", "workaholic gray"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // used to access the sidebar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//        ref = Database.database().reference()
//
//        if let user = Auth.auth().currentUser {
//            ref?.child("hours").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                self.totalTime = snapshot.value as! Int
//            })
//        }
//        checkAchievements()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Auth.auth().currentUser != nil {
            return achList.count
        }
        else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if Auth.auth().currentUser != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Achievement Cell", for: indexPath) as! AchievementsTableViewCell
        
            // Configure the cell...
            if achievements[indexPath.row] == 1 {
                cell.badge.image = UIImage(named: badges[indexPath.row])
            }
            else {
                cell.badge.image = UIImage(named: grayScale[indexPath.row])
            }
            
            cell.title.text = achList[indexPath.row][0]
            cell.cellDescription.text = achList[indexPath.row][1]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "If not logged in", for: indexPath) as! AchievementsTableViewCell
//            cell.messageConstraint.constant = (view.frame.height/2.0) - 42
//            cell.message.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height/2.0) - 42)
            
            return cell
        }
        
//        let tableViewCell = UITableViewCell()
//        if let user = Auth.auth().currentUser{
//            if achList.count > 0{
//                tableViewCell.textLabel?.font = UIFont(name: "helvetica neue", size: 15)
//                tableViewCell.textLabel?.textAlignment = .center
////                print(indexPath.row)
//                tableViewCell.textLabel?.text = achList[indexPath.row][0]
//            }
//        }
//        return tableViewCell
        
    }
 
    
    func checkAchievements(){
       
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
