//
//  OnboardingVC.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-16.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var index = 0
    var imageFileName = ""
    var pageContent = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.image = UIImage(named: imageFileName)
        contentLabel.text = pageContent
        
        pageControl.currentPage = index
        
        switch index {
        case 0...1:
            nextPageButton.setImage(UIImage(named: ""), for: UIControlState.normal)
        case 2:
            nextPageButton.setImage(UIImage(named: ""), for: UIControlState.normal)
            nextPageButton.isHidden = false
            pageControl.isHidden = true
        default:
            break
        }
    }
    
    @IBAction func nextPageButton_Pressed(_ sender: UIButton) {
        switch index {
        case 0...1:
            let pageVC = parent as! OnboardingPageVC
            pageVC.nextPage(index: index)
        case 2:
            // go to PetType Screen
            print("shown")
        default:
            break
        }
    }
    
}
