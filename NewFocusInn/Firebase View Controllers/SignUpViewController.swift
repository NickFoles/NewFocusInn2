//
//  SignUpViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signedUpHorizontalConstraint: NSLayoutConstraint!
    var ref: DatabaseReference!

    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil, error == nil {
                print("user created")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    print("couldn't change name")
                })
            }
            else {
                print("used1")
                print(error.debugDescription)
            }
            
        }
//        
//        ref = Database.database().reference()
//        
//        if let user = Auth.auth().currentUser{
//            ref?.child("houseList").child(user.uid).setValue([0,0,0,0,0])
//            ref?.child("achievementList").child(user.uid).setValue([0,0,0,0,0])
//            ref?.child("hours").child(user.uid).setValue(0)
//            //ref?.child("datetTimelineHistory").child(user.uid).setValue([""])
//        }
        
        moveMessage()
        self.dismiss(animated: true, completion: nil)
    }
    
    // moves a message which tells the user to tap the back button to reach their account homescreen if account was successfully made
    func moveMessage() {
        signedUpHorizontalConstraint.constant = 87.5
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4.5, options: .curveEaseInOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder {
            emailTextField.becomeFirstResponder()
        }
        else if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            signUpButton.isEnabled = true
        }
        return true
    }

}
