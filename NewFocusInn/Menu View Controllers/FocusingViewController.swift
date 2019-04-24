//
//  FocusingViewController.swift
//  NewFocusInn
//
//  Created by Trent Gaylord (student LM) on 3/5/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseDatabase

class FocusingViewController: UIViewController{
    var timermain = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self), userInfo: nil, repeats: false)
    var getBackTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self), userInfo: nil, repeats: false)
    var interval : Double = globalTime
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var updatetimer: Timer?
    var exitTime : String = "00:00:00"
    var timeleft = "00:00:00"
    var runCount = 0
    var ref : DatabaseReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
    
    @IBOutlet weak var buildingImage: UIImageView!
    
    // Creates the Timer based on the passed Interval Double in seconds
    func createTimer(_ interval:Double){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.runCount += 1
            let hours = Int((globalTime - Double(self.runCount))/60/60)
            let minutes = Int((globalTime - Double(self.runCount))/60)%60
            let second = Int((globalTime - Double(self.runCount))) % 60
            
            self.timerLabel.text = String(format:"%02d:%02d:%02d", hours, minutes, second)
            self.timeleft = String(format:"%02d:%02d:%02d", hours, minutes, second)
            
            if Double(self.runCount) == globalTime {
                timer.invalidate()
                
            // add building to houseList
                houseList.append(buildingNames[firstRow][imageClicks])
                
            // add building to timeline history
                if dates[0] != Date().weekdayNameAndDate {
                    dates.insert(Date().weekdayNameAndDate, at: 0)
                    timelineHistory.insert(["built", Date().time, "Successfully constructed a \(Int(globalTime)/60)-minute \(buildingNames[firstRow][imageClicks])", buildingNames[firstRow][imageClicks]], at: 0)
                }
                else {
                    timelineHistory[0].insert("built", at: 0)
                    timelineHistory[0].insert(Date().time, at: 1)
                    timelineHistory[0].insert("Successfully constructed a \(Int(globalTime))-minute \(buildingNames[firstRow][imageClicks])", at: 2)
                    timelineHistory[0].insert(buildingNames[firstRow][imageClicks], at: 3)
                }
                
            // check if achievements were completed
                // check 10 buildings achievement
                if sessions >= 10 && achievements[0] == 0 {
                    achievements[0] = 1
                    if dates[0] != Date().weekdayNameAndDate {
                        dates.insert(Date().weekdayNameAndDate, at: 0)
                        timelineHistory.insert(["achieved", Date().time, "New achievement unlocked: Freshmen", "10 buildings"], at: 0)
                    }
                    else {
                        timelineHistory[0].insert("achieved", at: 0)
                        timelineHistory[0].insert(Date().time, at: 1)
                        timelineHistory[0].insert("New achievement unlocked: Freshmen", at: 2)
                        timelineHistory[0].insert("10 buildings", at: 3)
                    }
                }
                // check 25 buildings achievement
                if sessions >= 25 && achievements[1] == 0 {
                    achievements[1] = 1
                    if dates[0] != Date().weekdayNameAndDate {
                        dates.insert(Date().weekdayNameAndDate, at: 0)
                        timelineHistory.insert(["achieved", Date().time, "New achievement unlocked: Veteran", "25 buildings"], at: 0)
                    }
                    else {
                        timelineHistory[0].insert("achieved", at: 0)
                        timelineHistory[0].insert(Date().time, at: 1)
                        timelineHistory[0].insert("New achievement unlocked: Veteran", at: 2)
                        timelineHistory[0].insert("25 buildings", at: 3)
                    }
                }
                // check 50 buildings achievement
                if sessions >= 50 && achievements[2] == 0 {
                    achievements[2] = 1
                    if dates[0] != Date().weekdayNameAndDate {
                        dates.insert(Date().weekdayNameAndDate, at: 0)
                        timelineHistory.insert(["achieved", Date().time, "New achievement unlocked: Senioritis", "50 buildings"], at: 0)
                    }
                    else {
                        timelineHistory[0].insert("achieved", at: 0)
                        timelineHistory[0].insert(Date().time, at: 1)
                        timelineHistory[0].insert("New achievement unlocked: Senioritis", at: 2)
                        timelineHistory[0].insert("50 buildings", at: 3)
                    }
                }
                // check workaholic achievement
                if totalTime >= 600 && achievements[3] == 0 {
                    achievements[3] = 1
                    if dates[0] != Date().weekdayNameAndDate {
                        dates.insert(Date().weekdayNameAndDate, at: 0)
                        timelineHistory.insert(["achieved", Date().time, "New achievement unlocked: Workaholic", "workaholic"], at: 0)
                    }
                    else {
                        timelineHistory[0].insert("achieved", at: 0)
                        timelineHistory[0].insert(Date().time, at: 1)
                        timelineHistory[0].insert("New achievement unlocked: Workaholic", at: 2)
                        timelineHistory[0].insert("workaholic", at: 3)
                    }
                }
                totalTime += Int(globalTime)
            
                self.ref.child("houseList").setValue(houseList)
                self.ref.child("timelineHistory").setValue(timelineHistory)
                self.ref.child("dates").setValue(dates)
                self.ref.child("achievementList").setValue(achievements)
                self.ref.child("hours").setValue(totalTime)
                
                print("DONE!")
            }
        }
        print("Timer Actually Created")
    }
    
    //Passes total time left in seconds
    func totaltimeleft()->Int{
        return Int(timermain.fireDate.timeIntervalSinceNow)
    }
    
    func timeLeftNotification() {
        print("Time Left Notifcation Here!")
        
        let content = UNMutableNotificationContent()
        
        //  content.body = NSString.localizedUserNotificationString(forKey: "You have "+String(exitTime)+" left in your studying session. You have exited early!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You have exited the app Early! Please Come Back! 30 Seconds Left!", arguments: nil)
        
        // content.badge = 1
        
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func completeNotification() {
        print("Completetion Left Notifcation Here!")
    
        let content = UNMutableNotificationContent()

        content.title = NSString.localizedUserNotificationString(forKey: "It's time to FocusInn!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You have finished your studying session!", arguments: nil)
        
        // content.body = "You've been away from the app for "+String(stopwatch.elapsedTime) + " seconds. Test123"
        // content.badge = 1
        
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func failureNotification() {
       // if(self.isViewLoaded){
        print("Failure Notifcation Here!")
        
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: "It's time to FocusInn!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You have failed your studying session!", arguments: nil)
        
        // content.badge = 1
        
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
            //UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
      // }
    }

    func exitEarly(){
        timermain.invalidate()
        self.completeNotification()
        
        // let shiftlose = LoseViewController
        //self.navigationController?.pushViewController(shiftlose, animated: true)
    }
    
    func storeExitTime(){
        guard var storeTime = timerLabel.text else {
            exitTime = "ERROR. TEST123"
            return
        }
        exitTime = storeTime
    }

    override func viewDidLoad() {
        print(globalTime)
        super.viewDidLoad()
        createTimer(interval)
    
        buildingImage.image = UIImage(named: buildingNames[firstRow][imageClicks])
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}
