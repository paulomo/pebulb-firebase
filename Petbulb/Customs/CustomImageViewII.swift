//
//  CustomImageViewII.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-29.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class CustomImageViewII: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }

}
