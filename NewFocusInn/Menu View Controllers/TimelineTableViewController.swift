//
//  TimelineTableViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

var dates = [String]()
var timelineHistory = [[String]]()

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

class TimelineTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // used to access the sidebar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dates.count
    }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionTimelineHistory = timelineHistory[section]
        return sectionTimelineHistory.count/4
    }

        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section]
    }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dates.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Timeline Cell", for: indexPath) as! TimelineTableViewCell
            let sectionTimelineHistory = timelineHistory[indexPath.section]
        
            // Configure the cell...
            cell.thumbnail.image = UIImage(named: sectionTimelineHistory[indexPath.row * 4])
            cell.time.text = sectionTimelineHistory[indexPath.row * 4 + 1]
            cell.cellDescription.text = sectionTimelineHistory[indexPath.row * 4 + 2]
            cell.cellImage.image = UIImage(named: sectionTimelineHistory[indexPath.row * 4 + 3])
            return cell
        }
        
        // uncomment when startFocusing is setup
     /*
        // creates the Building Cell, displaying the time a new building was constructed/destroyed, the description of the building, and its image
        else if newBuilding || destroyedBuilding {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Building Cell", for: indexPath) as! TimelineTableViewCell
         
            // Configure the cell...
            cell.buildingTime.text = Date().time
         
            if newBuilding {
                cell.buildingDescription = "Successfully constructed a \(timeConstructing)-minute \(buildingType)."
            }
            else {
                cell.buildingDescription = "You've destroyed a \(buildingType)."
            }
         
            cell.buildingImage.image = UIImage(named: "\(buildingType)")
            timelineHistory.append(cell)
            return cell
        }
         
         // creates the Achievement Cell, displaying the time an achievement was achieved, the name of the achievemnet , and its image
         else if newAchievement {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Achievement Cell", for: indexPath) as! TimelineTableViewCell
         
            // Configure the cell...
            cell.achievementTime.text = Date().time
            cell.achievementDescription = "New achievement unlocked: \(achievementType)."
            cell.achievementImage.image = UIImage(named: "\(achievementType)")
            timelineHistory.append(cell)
            return cell
            }
         */
        else {
            return UITableViewCell()
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
