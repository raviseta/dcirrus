//
//  TabBarViewController.swift
//  Dcirrus
//
//  Created by Gaadha on 19/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import ObjectMapper

class TabBarViewController: UITabBarController {

    @IBOutlet weak var m_tabbaritems: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.m_tabbaritems.unselectedItemTintColor = #colorLiteral(red: 0.4470588235, green: 0.8549019608, blue: 0.9490196078, alpha: 1)
    }

}

extension TabBarViewController{
    
}
