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
    override func viewDidLoad() {
        super.viewDidLoad()
        var storyBoard = Commen().storyBoard
        var urlStr:Array = Commen().url
        //给每个controller初始化一个Parser
        var p0 = Parser()
        var p1 = Parser()
        var p2 = Parser()
        
        var mhController = MHViewController()
        mhController = storyBoard.instantiateViewControllerWithIdentifier("MHView") as MHViewController
        mhController.title = "门户"
        p0.getData(urlStr[0])
        mhController.tableData = p0.parserDatas
        
        
        var zxController = ZXViewController()
        zxController = storyBoard.instantiateViewControllerWithIdentifier("ZXView") as ZXViewController
        zxController.title = "资讯"
        p1.getData(urlStr[1])
        zxController.tableData = p1.parserDatas
        
        var twController = TWViewController()
        twController = storyBoard.instantiateViewControllerWithIdentifier("TWView") as TWViewController
        twController.title = "图文"
        p2.getData(urlStr[2])
        twController.tableData = p2.parserDatas
        println(NSXMLParserError.InternalError.rawValue)
        
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
