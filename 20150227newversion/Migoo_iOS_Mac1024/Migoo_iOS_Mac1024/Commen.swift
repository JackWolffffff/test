//
//  Commen.swift
//  testSCNavTabBar
//
//  Created by rongjun on 14/12/30.
//  Copyright (c) Migoo. All rights reserved.


//  $(PRODUCT_NAME)
import UIKit

let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
let urlzx = "http://www.mac1024.com/portal.php?mod=rss&catid=1" //资讯
let urltw = "http://www.mac1024.com/portal.php?mod=rss&catid=2" //图文
let urlsp = "http://www.mac1024.com/portal.php?mod=rss&catid=4" //视频
let urlxm = "http://www.mac1024.com/portal.php?mod=rss&catid=5" //限免
let urllt = "http://wsq.discuz.qq.com/?siteid=264381556&source=wap&c=index&a=index&mobile=2" //论坛
let url_OSX = "http://www.mac1024.com/portal.php?mod=rss&catid=11" //OSX限免
let url_iPhone = "http://www.mac1024.com/portal.php?mod=rss&catid=12" //iPhone限免
let url_AppleWatch = "http://www.mac1024.com/portal.php?mod=rss&catid=13" //AppleWatch限免
let urlRank = "http://www.mac1024.com/portal.php?mod=rss&catid=6" //应用排行
var tableData_Globle:Array<MigooRSS> = []
