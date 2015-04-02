//
//  VideoViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/4/2.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var atableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("") as UITableViewCell
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
   
}
