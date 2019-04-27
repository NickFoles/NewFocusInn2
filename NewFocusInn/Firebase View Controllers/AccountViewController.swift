//
//  AccountViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stats: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    var achieved = 0
    var imagePicker: UIImagePickerController?
    var ref: DatabaseReference!
    
    @IBAction func logOutTouchedUp(_ sender: UIButton) {
        try! Auth.auth().signOut()
    }
    
    @IBAction func changePictureTouchedUp(_ sender: UIButton) {
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = pickedImage // set the imageView to display the selected image
            uploadProfilePicture(pickedImage) {url in
                guard let uid = Auth.auth().currentUser?.uid else {return}
                guard let imageURL = url else {return}
                let database = Database.database().reference().child("users/\(uid)").child("profilePic")
                
                let userObject: [String: Any] =  ["photoURL": imageURL.absoluteString]
                
                database.setValue(userObject)
            }
        }
        imagePicker?.dismiss(animated: true, completion: nil)
        
    }
    
    func uploadProfilePicture(_ image: UIImage, _ completion: @escaping((_ url: URL?) -> ())) {
        // get the current user'e userid
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // get a reference to the storage object
        let storage = Storage.storage().reference().child("users/\(uid)")
        
        // image's must be saved as data object's to convert and compress the image
        guard let image = imageView?.image, let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        // store the image
        storage.putData(imageData, metadata: StorageMetadata()) { (metaData, error) in
            if error == nil && metaData != nil {
                storage.downloadURL { url, error in
                    guard let downloadURL = url else {return}
                    completion(downloadURL)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    @IBAction func downloadPicture(_ sender: UIButton) {
        
    }
    
    func getImageURL(_completion: @escaping((_ url:String?) -> ())) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let databaseRef = Database.database().reference().child("users/\(uid)").child("profilePic")
        
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            let postDict = snapshot.value as? [String: AnyObject] ?? [:]
            
            if let photURL = postDict["photoURL"] {
                _completion(photURL as? String)
            }
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(firstSignUp)
        username.text = Auth.auth().currentUser?.displayName
        
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = true
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.delegate = self
        
        // displays a circular border around the profile image
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        // displays user's profile image
        getImageURL(){ url in
            let storage = Storage.storage()
            guard let imageURl = url else {return}
            let ref = storage.reference(forURL: imageURl)
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error == nil && data != nil {
                    self.imageView.image = UIImage(data: data!)
                    self.reloadInputViews()
                }
                else{
                    print(error?.localizedDescription as Any)
                }
            }
        }
        
        for i in 0 ..< achievements.count {
            if achievements[i] == 1 {
                achieved += 1
            }
        }
    
        stats.text = "🏠 \(houseList.count)     🏆 \(achieved)"
        
        // days
        if totalTime/1440 < 2 {
            totalTimeLabel.text = "🕒 \(totalTime/1440) day"
        }
        else {
            totalTimeLabel.text = "🕒 \(totalTime/1440) days"
        }
        // hours
        if totalTime/60 < 2 {
            totalTimeLabel.text = "\(totalTimeLabel.text!) \(totalTime/60) hour"
        }
        else {
            totalTimeLabel.text = "\(totalTimeLabel.text!) \(totalTime/60) hours"
        }
        // minutes
        if totalTime < 2 {
            totalTimeLabel.text = "\(totalTimeLabel.text!) \(totalTime) min"
        }
        else {
            totalTimeLabel.text = "\(totalTimeLabel.text!) \(totalTime) mins"
        }
        
        if firstSignUp == 1, let user = Auth.auth().currentUser{
            
            ref = Database.database().reference().child("users").child(user.uid)

            ref?.child("houseList").setValue([""])                  // lists the buildings, indices correlate to the coordinate of the buildings
            ref?.child("sessions").setValue(0)                      // total amount of session taken
            ref?.child("achievementList").setValue([0,0,0,0])       // value equals 1 if the achievement correlating to the index is achieved
            ref?.child("totalMinutes").setValue(0)                  // total hours spent focusing
            
            ref?.child("timelineHistory").setValue([[""]])          // stores information of each item on the timeline
            ref?.child("dates").setValue([""])                      // dates for timelineHistory
            print("sent information")
        }
        else {
            let user = Auth.auth().currentUser
            if user != nil {
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
            }
        }
        
        // Do any additional setup after loading the view.
    }

}
