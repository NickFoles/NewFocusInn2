//
//  LogInViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var ref: DatabaseReference!
    
    // takes the user to their account homescreen if successfully logged in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
            self.performSegue(withIdentifier: "firebaseHome", sender: self)
        }
    }
    
    @IBAction func logInButtonTouchedUp(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                self.viewDidAppear(true)
            }
            else {
                print(error!.localizedDescription)
            }
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            logInButton.isEnabled = true
        }
        return true
    }
}
