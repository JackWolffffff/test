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
        var quanquan = JvHua(frame: CGRectMake(self.view.bounds.width/2 - 25, self.view.bounds.height/2 - 25, 50, 50))
        self.refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        self.atableView.showsVerticalScrollIndicator = false
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        self.atableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.atableView.addSubview(refresh)
        
        dispatch_async(dispatch_get_global_queue(0, 0), {
            // 处理耗时操作的代码块...
            var p = Parser()
            p.getData(self.parseUrl)
//            tableData_Globle = p.parserDatas
            self.tableData = p.parserDatas
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), {
            self.atableView.reloadData()
            });
        })
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
        println(indexPath)
        return (self.view.bounds.size.width - 20) * 2/3 + 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("cell")
        println(tableData.count)
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        var imageView = UIImageView(frame: CGRectMake(10, 5, cell.bounds.size.width-20, (cell.bounds.size.width - 20)*2/3))
        var titleLabel = UILabel(frame: CGRectMake(0, imageView.bounds.height - 30, imageView.bounds.width, 30))
        titleLabel.backgroundColor = UIColor(red: 0.439, green: 0.757, blue: 0.918, alpha: 0.8)
        if tableData.count > 0 {
            titleLabel.text = tableData[indexPath.item].title
            var url = NSURL(string: tableData[indexPath.item].enclosure)
            var request = NSURLRequest(URL: url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                if data != nil {
                    imageView.image = UIImage(data: data)
                } else {
                    NSLog("data is nil")
                }
            }
        imageView.addSubview(titleLabel)
        cell.addSubview(imageView)
        }
        return cell
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        touches
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle = UITableViewCellSelectionStyle.Gray
        var articleView = storyboard?.instantiateViewControllerWithIdentifier("articleView") as! ArticleShowViewController
        articleView.migoo = tableData[indexPath.item]
        articleView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(articleView, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            cell.viewWithTag(3)?.alpha = 1.0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

