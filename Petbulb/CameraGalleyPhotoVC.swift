//
//  CameraGalleyPhotoVCViewController.swift
//  Petbulb
//
//  Created by MACPRO on 2017-12-04.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD


class CameraGalleyPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var viewForImageAndTextInput: UIView!
    @IBOutlet weak var imageSelectedToPost: UIImageView!
    @IBOutlet weak var captionTextToPost: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var postImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForImageAndTextInput.isHidden = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForImageInPost()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // function to upload images from phone gallery
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewForImageAndTextInput.isHidden = false
            imageSelectedToPost.image = pickedImage
            postImage = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkForImageInPost() {
        if postImage != nil {
            postButton.isEnabled = true
            postButton.alpha = 1
        } else {
            //Disenabling the postButton
            postButton.isEnabled = false
            postButton.alpha = 0.5
        }
    }
    
    // function to post image and text
    @IBAction func postButton_Pressed(_ sender: UIButton) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let postImg = self.postImage, let imageData = UIImageJPEGRepresentation(postImg, 0.1) {
            let photoIDString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts_image").child(photoIDString)
            
            storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                let photoUrl = metaData?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl!)
            })
        } else {
            // Tell user to add photo
            ProgressHUD.showError("Add a photo")
        }
        
    }
    
    func sendDataToDatabase(photoUrl: String) {
        let postType = "photo"
        let databaseRef = Database.database().reference()
        let postsReference = databaseRef.child("posts")
        let newPostID = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostID)
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "posttype": postType, "photoUrl": photoUrl, "caption": captionTextToPost.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.captionTextToPost.text = ""
            self.imageSelectedToPost.image = UIImage(named: "")
            self.postImage = nil
            self.tabBarController?.selectedIndex = 0
        })
    }
    
}


