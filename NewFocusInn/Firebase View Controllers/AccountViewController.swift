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
    var imagePicker: UIImagePickerController?
    
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
                let database = Database.database().reference().child("user/\(uid)")
                
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
        let storage = Storage.storage().reference().child("user/\(uid)")
        
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
        
        let databaseRef = Database.database().reference().child("user/\(uid)")
        
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
        username.text = Auth.auth().currentUser?.displayName
        
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = true
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.delegate = self
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

}
