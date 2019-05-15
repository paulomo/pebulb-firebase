//
//  BaseRoundedButton.swift
//  Petbulb
//
//  Created by MACPRO on 2017-10-20.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class BaseRoundedButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}
