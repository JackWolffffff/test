//
//  VideoViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/4/2.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var atableView: UITableView!
    var tableData:Array<MigooRSS> = []
    var refresh = UIRefreshControl()
    
    let parseUrl = urlsp
    override func viewDidLoad() {
        super.viewDidLoad()
        self.atableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.atableView.showsVerticalScrollIndicator = false
        self.refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        self.atableView.addSubview(refresh)
        self.loadData()
        
        
    }
    
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUrl)
        tableData = p1.parserDatas
        self.refresh.endRefreshing()
        self.atableView.reloadData()
    }
    
    func loadData(){
        dispatch_async(dispatch_get_global_queue(0, 0), {
            // 处理耗时操作的代码块...
            //请求数据
            var p = Parser()
            if p.getData(self.parseUrl) {
                tableData_Globle = p.parserDatas
                self.tableData = tableData_Globle
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), {
                    JvHua.setHidden(true)
                    self.atableView.reloadData()
                })
            } else {
                JvHua.setHidden(true)
                var alert = UIAlertView(title: "提示", message: "数据请求失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再试一次")
                
                alert.show()
            }
            
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        var imageView = UIImageView(frame: CGRectMake(10, 5, self.view.bounds.size.width-20, (self.view.bounds.size.width - 20)*2/3))
//        var webView = UIWebView(frame: CGRectMake(10, 5, cell.bounds.size.width-20, (cell.bounds.size.width - 20)*2/3))
        cell.addSubview(imageView)
        if tableData.count > 0 {
            var url = NSURL(string: tableData[indexPath.item].enclosure)
            var request = NSURLRequest(URL: url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                if data != nil {
                    imageView.image = UIImage(data: data)
                } else {
                    println("data is nil")
                }
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var articleView = storyBoard.instantiateViewControllerWithIdentifier("articleView") as ArticleShowViewController
        articleView.migoo = tableData[indexPath.item]
        articleView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(articleView, animated: true)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.1, 0.1)
        UIView.animateWithDuration(0.5, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            cell.viewWithTag(3)?.alpha = 1.0
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.bounds.size.width - 20) * 2/3 + 10
    }
    
   
}
