//
//  SCNavigator.swift
//  MigooAPP
//
//  Created by 戎军 on 15/1/22.
//  Copyright (c) 2015年 rongjun. All rights reserved.
//

import UIKit

class SCNavigator: UIViewController {
    
    let def = Define()
    //给每个controller初始化一个Parser
    var p0 = Parser()
    var p1 = Parser()
    var p2 = Parser()
    var urlStr:Array<String> = Commen().url
    var mhController:MHViewController!
    var zxController:ZXViewController!
    var twController:TWViewController!
    
    override func viewDidLoad() {
        var storyBoard = Commen().storyBoard
        mhController = storyBoard.instantiateViewControllerWithIdentifier("MHView") as MHViewController
        mhController.title = "门户"
        
        zxController = storyBoard.instantiateViewControllerWithIdentifier("ZXView") as ZXViewController
        zxController.title = "资讯"
        
        twController = storyBoard.instantiateViewControllerWithIdentifier("TWView") as TWViewController
        twController.title = "图文"
        
        p0.getData(urlStr[0])
        p1.getData(urlStr[1])
        p2.getData(urlStr[2])
        mhController.tableData = p0.parserDatas
        zxController.tableData = p1.parserDatas
        twController.tableData = p2.parserDatas
        
        var navTabBarController = SCNavTabBarController()
        navTabBarController.subViewControllers = [mhController, zxController, twController]
        navTabBarController.showArrowButton = true
        navTabBarController.view.frame = CGRectMake(0, 0, def.screenWidth(), def.screenHeight())
        navTabBarController.addParentController(self)
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }

}
