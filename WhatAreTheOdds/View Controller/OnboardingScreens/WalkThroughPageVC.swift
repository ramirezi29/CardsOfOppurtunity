//
//  WalkThroughPageVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 1/14/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

// Info that changes through out the screens
protocol WalkThroughPageVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkThroughPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
          return UIViewController()
    }
    

    var currentIndex = 0
    let walkThroughKey = "walkThroughKey"
    var currentVC: WalkThroughVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
    }
    



}
