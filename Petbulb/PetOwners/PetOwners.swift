//
//  PetOwners.swift
//  Petbulb
//
//  Created by MACPRO on 2017-10-20.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

struct PetOwners {
    
    private var _firstName : String?
    private var _lastName : String?
    private var _userName : String?
    var fullName : String? {
        return "\(String(describing: _firstName)) \(String(describing: _lastName))"
    }
    private var _age : Int?
    private var _currentCity : String?
    private var _gender : Gender?
    private var _profession : Profession?
    private var _numberOfPet : PetType? // more worj to be done here to ensure it works with petType
    private var _petType : PetType?
    private var _PetBreed : PetBreed?
    private var _yearsOwnedAPet : Int?
    private var _profilePicture : UIImage?
    private var _coverPicture : UIImage?
    
}
