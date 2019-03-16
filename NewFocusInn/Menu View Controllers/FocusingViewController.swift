//
//  FocusingViewController.swift
//  NewFocusInn
//
//  Created by Trent Gaylord (student LM) on 3/5/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import UserNotifications

class FocusingViewController: UIViewController{
    
    var timermain = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self), userInfo: nil, repeats: false)
    
    var interval : Double = globalTime
    @IBOutlet weak var timerLabel: UILabel!
    var updatetimer: Timer?
    
    var timeleft = "00:00:00"
    
    //Creates the Timer based on the passed Interval Double in seconds
    
    func createTimer(_ interval:Double){
        //timermain = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.timerdone(_:)), userInfo: nil, repeats: false)
        timermain = Timer.scheduledTimer(withTimeInterval: interval, repeats: false){
            timermain in
         //   self.completeNotification()
         // let shiftwin = CompletionViewController()
            print("Timer Done 2.0")
            //self.navigationController?.pushViewController(shiftwin, animated: true)
        }
        print("Timer Actually Created")
        
    }
    
    //Updates the Label...
    @objc func updateLabel(){
        //  updatetimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        let hours = Int(timermain.fireDate.timeIntervalSinceNow/60/24)
        let minutes = Int(timermain.fireDate.timeIntervalSinceNow/60)
        let second = Int(timermain.fireDate.timeIntervalSinceNow) % 60
        
        timerLabel.text = String(format:"%02d:%02d:%02d", hours, minutes, second)
        timeleft = String(format:"%02d:%02d:%02d", hours, minutes, second)
    }
    
    //Passes total time left in seconds
    func totaltimeleft()->Int{
        return Int(timermain.fireDate.timeIntervalSinceNow)
    }
    
    override func viewDidLoad() {
        print(globalTime)
        super.viewDidLoad()
         updatetimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        createTimer(interval)
        updateLabel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
