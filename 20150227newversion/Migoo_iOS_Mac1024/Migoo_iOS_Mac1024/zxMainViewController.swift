//
//  zxMainViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by 戎军RJ on 15/4/5.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class zxMainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var zx = storyBoard.instantiateViewControllerWithIdentifier("zxview") as ZXViewController
        zx.title = "资讯"
        var xm = storyBoard.instantiateViewControllerWithIdentifier("xmview") as XMViewController
        xm.title = "限免"
        var xmOSX = storyBoard.instantiateViewControllerWithIdentifier("xm_OSXView") as OSXViewController
        xmOSX.title = "OS X"
        var xmiPhone = storyBoard.instantiateViewControllerWithIdentifier("xm_iPhoneView") as iPhoneViewController
        xmiPhone.title = "iPhone"
        var xmAppleWatch = storyBoard.instantiateViewControllerWithIdentifier("xm_AppleWatchView") as AppleWatchViewController
        xmAppleWatch.title = "Watch"
        var xmRank = storyBoard.instantiateViewControllerWithIdentifier("xm_RankView") as RankViewController
        xmRank.title = "排行"
        
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        var sc = SCNavTabBarController()
        sc.showArrowButton = true
        sc.subViewControllers = [zx, xm, xmOSX, xmiPhone, xmAppleWatch, xmRank]
        sc.addParentController(self)
    }
}
