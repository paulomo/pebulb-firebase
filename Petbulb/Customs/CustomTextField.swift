//
//  CustomTextField.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-17.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
//        self.backgroundColor = UIColor.clear
//        let bottomLayer = CALayer()
//        bottomLayer.frame = CGRect(x: 0, y: 29, width: self.frame.width, height: 1.5)
//        bottomLayer.backgroundColor = DataServices.instance.hexStringToUIColor(hex: "#32c0fa").cgColor
//        self.layer.addSublayer(bottomLayer)
        
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = DataServices.instance.hexStringToUIColor(hex: "#32c0fa").cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  1000, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
