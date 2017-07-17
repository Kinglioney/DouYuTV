//
//  MainViewController.swift
//  DouYuTV
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func addChildVC(_ storyName : String){
        //1、通过StoryBoard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!

        //2、将childVC作为子控制器
        addChildViewController(childVC)

    }

}
