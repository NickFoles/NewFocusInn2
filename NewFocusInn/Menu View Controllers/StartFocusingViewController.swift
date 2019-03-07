//
//  StartFocusingViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit

class StartFocusingViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    private var time:[[Int]] = [[0,1,2,3],[0,5,10,15,20,25,30,35,40,45,50,55]]
    var secondsToSend: Double = 0
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
  
    @IBOutlet weak var timeSetter: UIPickerView!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        secondsToSend = Double(time[0][timeSetter.selectedRow(inComponent: 0)])*60*60+Double(time[1][timeSetter.selectedRow(inComponent: 0)])*60
        weak var passer:FocusingViewController?
       if let passing = passer{
            passing.createTimer(secondsToSend)}
        let storyboard = UIStoryboard(name: "FocusingScreen", bundle: nil)
        let transition:FocusingViewController = self.storyboard?.instantiateViewController(withIdentifier: "FocusingViewController") as! FocusingViewController
        self.navigationController?.pushViewController(transition, animated: false)
      
    }
    
    //Sets number of Components for PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
   
    //Sets PickerView Component Lengths
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return 4
        }
        return 12
        
    }
    
    //Gives access to Seconds sent in preparation for Segue
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        //performSegue(withIdentifier: "Seconds Sent", sender: secondsToSend)
        
    }
    
    //Sets up the Label for the Hours/Minutes. A Hot mess of code, will fix eventually
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//          let label = UILabel()
//          label.text = String(row)
//          label.textAlignment = .center
//          return label
//    }
//   
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {
//            
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
//        
//                timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 1))
//                timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 0))
//        
//    }
//    func selectPickerViewRows() {
//
//        timeSetter.selectRow(0, inComponent: 0, animated: false)
//        timeSetter.selectRow(0, inComponent: 1, animated: false)
//
//        timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 1))
//        timeSetter(pickerView(timeSetter, didSelectRow: 0, inComponent: 0))
//    }
    
    //Sets up the Data inside the PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return String(time[0][row])}
        return String(time[1][row])
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? FocusingViewController, secondsToSend = sender as? Int{
//            vc.
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeSetter.delegate = self
        self.timeSetter.dataSource = self
        print(time[1][2])
        
        
//        for i in 0...3{
//            time[0][i] = i
//        }
//        for j in 0...11{
//            time[0][j] = j*5
//        }
        /*time[0] = [0,1,2,3]
        time[1] = [0,5,10,15,20,25,30,35,40,45,50,55]*/
       
        //timeSetter.selectRow(2, inComponent: 2, animated: false)
        //selectPickerViewRows()
        
        // used to access the sidebar menu

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

}
