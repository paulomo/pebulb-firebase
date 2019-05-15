//
//  AuthService.swift
//  Petbulb
//
//  Created by MACPRO on 2017-12-08.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class AuthService {
    
    static func LogIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    
    static func SignUp(firstname: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void ) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            storageRef.putData(imageData, metadata: nil, completion: { (metaData, erro) in
                if error != nil {
                    return
                }
                
                let profileImageUrl = metaData?.downloadURL()?.absoluteString
                
                self.setUpInformation(userFirstName: firstname, userEmail: email, userProfileImageUrl: profileImageUrl!, uid: uid!, onSuccess: onSuccess)
                
                
            })
        }
    }
    
    static func setUpInformation(userFirstName: String, userEmail: String, userProfileImageUrl: String, uid: String, onSuccess: @escaping () -> Void) {
        let databaseRef = Database.database().reference()
        let userReference = databaseRef.child("users")
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["firstname": userFirstName, "email": userEmail, "profileImageUrl": userProfileImageUrl])
        onSuccess()
        
    }
    
}



