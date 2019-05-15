//
//  Pet.swift
//  Petbulb
//
//  Created by MACPRO on 2017-10-20.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

struct Pet {
    
    private var _name : String?
    private var _age : Int?
    private var _gender : Gender?
    private var _birthCity : String?
    private var _petType : PetType?
    private var _breed : PetBreed?
    private var _height : Float?
    private var _weight : Float?
    private var _petPersonality : PetPersonality?
    private var _profilePicture : UIImage?
    private var _coverPicture : UIImage?
    
    var name : String {
        get {
                return _name!
        }
        set {
            _name = newValue
        }
    }
    
    var age : Int {
        get {
            return _age!
        }
        set {
            _age = newValue
        }
    }

}
