//
//  CameraTextVC.swift
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


class CameraTextVC: UIViewController {
    
    
    @IBOutlet weak var userTextInput: UITextView!
    @IBOutlet weak var buttonsView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsView.removeFromSuperview()
        self.userTextInput.inputAccessoryView = buttonsView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userTextInput.becomeFirstResponder()
        
    }
    
    
    @IBAction func postTextButton_Pressed(_ sender: UIButton) {
        view.endEditing(true)
        sendDataToDatabase()
        
    }
    
    func sendDataToDatabase() {
        ProgressHUD.show("Waiting...", interaction: false)

        let postType = "text"
        let databaseRef = Database.database().reference()
        let postsReference = databaseRef.child("posts")
        let newPostID = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostID)
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "posttype": postType, "caption": userTextInput.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }else {
               ProgressHUD.showSuccess("Success")
            }
            self.userTextInput.text = ""
            self.tabBarController?.selectedIndex = 0
        })
    }
    
    
    @IBAction func advicePostButton_Pressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func photoPostButton_Pressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func videoPostButton_Pressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func backButton_Pressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
