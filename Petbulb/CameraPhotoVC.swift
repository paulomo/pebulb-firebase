//
//  CameraVC.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-27.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD


class CameraPhotoVC: UIViewController {
    
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var snappedImage: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageForPost = snappedImage {
        imageToPost.image = imageForPost
        }
        
    }
    
    @IBAction func postButton_Pressed(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let postImg = self.snappedImage, let imageData = UIImageJPEGRepresentation(postImg, 0.1) {
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
        let databaseRef = Database.database().reference()
        let postsReference = databaseRef.child("posts")
        let newPostID = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostID)
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "photoUrl": photoUrl, "caption": captionText.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.captionText.text = ""
            self.imageToPost.image = UIImage(named: "")
            self.snappedImage = nil
            //self.tabBarController?.selectedIndex = 0
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}



