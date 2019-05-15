//
//  OnboardingVCViewController.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-09.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageContent = ["Learn and share with Pet Owners with similar pet, breed, interests and challenges in a safe space.", "Your profile is associated with your pet profile giving that same real world connection you share with your pet", "Our goal is to let you tell us what pet product or services you use or need and we find the best deal for you."]
    
    var pageImage = ["onboardingimage1.png", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        dataSource = self
        
        if let firstPageVC = viewControllerAtIndex(index: 0) {
            setViewControllers([firstPageVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingVC).index
        index += 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingVC).index
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index: Int) -> OnboardingVC? {
        if index < 0 || index >= pageContent.count {
            return nil
        }
        if let pageContentVC = storyboard?.instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC {
            pageContentVC.pageContent = pageContent[index]
            pageContentVC.index = index
            pageContentVC.imageFileName = pageImage[index]
            return pageContentVC
        }
        return nil
    }
    
    func nextPage(index: Int) {
        if let nextVC = viewControllerAtIndex(index: index + 1) {
            setViewControllers([nextVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }
}
