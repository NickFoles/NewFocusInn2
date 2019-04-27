//
//  StartFocusingViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

var globalTime : Double = 0

var imageClicks = 0
var firstRow = 0
let buildingNames = [["house", "pink house", "newspaper place"], ["ice cream store", "cinema", "petco"], ["tall building", "gray building", "wawa"], ["state building", "eiffel tower"]]

import UIKit

class StartFocusingViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var buildingImage: UIImageView!
    
    private var time:[[Int]] = [[0,1,2,3],[0,5,10,15,20,25,30,35,40,45,50,55]]
    var secondsToSend: Double = 0
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // for the cancel button in the startFocusing view controller
    @IBAction func backToStartFocusing(unwindSegue: UIStoryboardSegue) {
        cancelled = 1
    }
    
    @IBAction func buildingImageButton(_ sender: UIButton) {
        if imageClicks < buildingNames[firstRow].count - 1 {
            imageClicks += 1
        }
        else {
            imageClicks = 0
        }
        buildingImage.image = UIImage(named: buildingNames[firstRow][imageClicks])
    }
    
    @IBOutlet weak var timeSetter: UIPickerView!
    
    @IBAction func setFocusingTimer(_ sender: UIButton) {
        secondsToSend = Double(time[0][timeSetter.selectedRow(inComponent: 0)])*60*60+Double(time[1][timeSetter.selectedRow(inComponent:1)])*60
        print(secondsToSend)
        globalTime = secondsToSend
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //Sets PickerView Component Lengths
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 4
        }
        return 12
    }
    
    //Gives access to Seconds sent in preparation for Segue
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let min = Double(time[0][timeSetter.selectedRow(inComponent: 0)])*60 + Double(time[1][timeSetter.selectedRow(inComponent:1)])
        if min >= 0 && min < 60 {
            buildingImage.image = UIImage(named: buildingNames[0][0])
            firstRow = 0
        }
        else if min >= 60 && min < 120{
            buildingImage.image = UIImage(named: buildingNames[1][0])
            firstRow = 1
        }
        else if min >= 120 && min < 180{
            buildingImage.image = UIImage(named: buildingNames[2][0])
            firstRow = 2
        }
        else if min >= 180{
            buildingImage.image = UIImage(named: buildingNames[3][0])
            firstRow = 3
        }
        
        imageClicks = 0
    }
    
    
    
    // Sets up the Label for the Hours/Minutes. A Hot mess of code, will fix eventually
    //    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    //          let label = UILabel()
    //          label.text = String(row)
    //          label.textAlignment = .center
    //          return label
    //    }
    
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {

    //            if component == 0, row > 1 {
    //                label.text = String(row) + " hours"
    //            }
    //            else if component == 0 {
    //                label.text = String(row) + " hour"
    //            }
    //            else if component == 1 {
    //                label.text = String(row) + " min"
    //            }
    //        }
    //                timeSetter.selectRow(0, inComponent: 0, animated: false)
    //                timeSetter.selectRow(0, inComponent: 1, animated: false)
    //                timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 1))
    //                timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 0))
    //    }
    
    //    func selectPickerViewRows() {
    //        timeSetter.selectRow(0, inComponent: 0, animated: false)
    //        timeSetter.selectRow(0, inComponent: 1, animated: false)
    //        timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 1))
    //        timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 0))
    //    }
    
    
    
    //Sets up the Data inside the PickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return String(time[0][row])
        }
        return String(time[1][row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeSetter.delegate = self
        self.timeSetter.dataSource = self

        buildingImage.image = UIImage(named: buildingNames[0][0])
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
}


