//
//  ArticleShowViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/2/27.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class ArticleShowViewController: UIViewController {
    var articleContent:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        println("article:\(articleContent)")
    }
}
