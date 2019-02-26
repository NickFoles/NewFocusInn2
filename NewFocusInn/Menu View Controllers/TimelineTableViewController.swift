//
//  TimelineTableViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit

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
    @IBOutlet var timelineTableView: UITableView!
    var totalTimelineItems = Int()
    var dayTimelineItems = Int()
    var rowNum = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTimelineItems += dayTimelineItems
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        dayTimelineItems = 1
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalTimelineItems
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dayTimelineItems == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Date Cell", for: indexPath) as! TimelineTableViewCell
            
            // Configure the cell...
            cell.dateLabel.text = Date().weekdayNameAndDate
            print("ran")
            return cell
        }
        
     /* else if newBuilding || destroyedBuilding {
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
            return cell
        }
         
         else if newAchievement {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Achievement Cell", for: indexPath) as! TimelineTableViewCell
         
            // Configure the cell...
            cell.achievementTime.text = Date().time
            cell.achievementDescription = "New achievement unlocked \(achievementType)."
            cell.achievementImage.image = UIImage(named: "\(achievementType)")
            return cell
            }
     */
       return UITableViewCell()
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
