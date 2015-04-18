//
//  BaseViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/4/18.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var tableData:Array<MigooRSS> = []
    let def = Define()
    var refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
