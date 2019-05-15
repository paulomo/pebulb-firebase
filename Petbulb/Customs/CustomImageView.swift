//
//  CustomImageView.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-28.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}
