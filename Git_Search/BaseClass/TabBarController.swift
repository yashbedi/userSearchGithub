//
//  TabBarController.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let searchVC = SearchViewController()
        let searchIcon = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.tabBarItem = searchIcon
        
        
        let recentsVC = RecentsViewController()
        let recentsIcon = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        recentsVC.tabBarItem = recentsIcon
        
        viewControllers = [searchVC,recentsVC]
    }
}

extension TabBarController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
