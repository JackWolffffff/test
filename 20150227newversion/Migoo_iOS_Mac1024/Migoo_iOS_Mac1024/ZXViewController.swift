//
//  FirstViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by 戎军 on 15/2/27.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class ZXViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableData:Array<MigooRSS> = []
    var parseUrl = Commen().url[2]
    
    var imageCache = Dictionary<String, UIImage>()
    var refresh = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        tableView.addSubview(refresh)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        var p = Parser()
        p.getData(parseUrl)
        tableData = p.parserDatas
        // Do any additional setup after loading the view, typically from a nib.
    }

    //刷新数据
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUrl)
        tableData = p1.parserDatas
        self.refresh.endRefreshing()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //tableView一节中显示的数据条数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //tableView的节
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        //设置标题
        
        return cell
    }
    


}
