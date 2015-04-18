//
//  XMViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by 戎军RJ on 15/4/6.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class XMViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    var tableData:Array<MigooRSS> = []
    var parseUrl = urlxm
    let TAG_IMAGE = 1
    let TAG_TITLELABEL = 2
    let TAG_DATELABEL = 3
    let def = Define()
    //缩略图缓存
    var imageCache = Dictionary<String, UIImage>()
    var refresh = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载数据指示器
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        self.tableView.addSubview(refresh)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        //异步获取数据
        self.loadData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadData(){
        dispatch_async(dispatch_get_global_queue(0, 0), {
            // 处理耗时操作的代码块...
            //请求数据
            var p = Parser()
            var quanquan = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-150, width: 100, height: 100))
            self.view.addSubview(quanquan)
            if p.getData(self.parseUrl) {
                //                tableData_Globle = p.parserDatas
                self.tableData = p.parserDatas
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    quanquan.hidden = true
                })
            } else {
                var alert = UIAlertView(title: "提示", message: "数据请求失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再试一次")
                
                alert.show()
            }
            
        })
    }
    
    //刷新数据
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUrl)
        tableData = []
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        //设置标题
        
        var time = tableData[indexPath.item].pubDate
        var day = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 5), end: advance(time.startIndex, 7)))
        var month = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 8), end: advance(time.startIndex, 11)))
        var year = time.substringWithRange(Range<String.Index>(start:advance(time.startIndex, 12), end: advance(time.startIndex, 16)))
        var author = tableData[indexPath.item].author
        var titleLabel = cell.viewWithTag(TAG_TITLELABEL) as? UILabel
        var imageView = cell.viewWithTag(TAG_IMAGE) as? UIImageView
        var dateLabel = cell.viewWithTag(TAG_DATELABEL) as? UILabel
        titleLabel?.text = tableData[indexPath.item].title
        dateLabel?.text = "\(day)/\(month)/\(year) edit by \(author)"
        //设置图标
        let url = tableData[indexPath.item].enclosure
        let image = self.imageCache[url]
        //var vImage = cell.imageView?.image
        if image? == nil {
            let imgUrl = NSURL(string: url)
            let request = NSURLRequest(URL: imgUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: { (response:NSURLResponse!, data:NSData!, error:NSError!)
                -> Void in
                if data != nil {
                    
                    imageView?.image = UIImage(data: data)
                    //self.imageCache[url] = imageView?.image
                } else {
                    imageView?.image = UIImage(named: "default.png")
                }
            })
        } else {
            imageView?.image = image
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var articleView = storyBoard.instantiateViewControllerWithIdentifier("articleView") as ArticleShowViewController
        articleView.migoo = tableData[indexPath.item]
        articleView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(articleView, animated:true)
        
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            cell.viewWithTag(3)?.alpha = 1.0
        })
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
