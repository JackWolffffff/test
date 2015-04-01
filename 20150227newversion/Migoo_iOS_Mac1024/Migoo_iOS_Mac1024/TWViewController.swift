//
//  SecondViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by 戎军 on 15/2/27.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class TWViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var atableView: UITableView!
    var tableData:Array<MigooRSS> = []
    var parseUrl = urltw
    let def = Define()
    var refresh = UIRefreshControl()
//    var imageCache = Dictionary<String, UIImage>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        self.atableView.addSubview(refresh)
        
        dispatch_async()
        var p = Parser()
        p.getData(parseUrl)
        tableData = p.parserDatas
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUrl)
        tableData = p1.parserDatas
        self.refresh.endRefreshing()
        self.atableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        NSLog("return tableRowHeight")
        return 162
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        NSLog("cell")
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var imageView = UIImageView(frame: CGRectMake(10, 5, cell.bounds.size.width-20, cell.bounds.size.height-10))
        var url = NSURL(string: tableData[indexPath.item].enclosure)
        var request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if data != nil {
                imageView.image = UIImage(data: data)
            } else {
                NSLog("data is nil")
            }
         
        }
        cell.addSubview(imageView)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

