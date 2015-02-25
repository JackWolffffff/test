//
//  ZXViewController.swift
//  testSCNavTabBar
//
//  Created by 戎军 on 15/1/22.
//  Copyright (c) 2015年 戎军. All rights reserved.
//

import UIKit

class MHViewController:  UITableViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var delegate:PassValue?
    var tableData:Array<MigooRSS> = []
    var parseUlr = Commen().url[0]
    //缩略图缓存
    var imageCache = Dictionary<String,UIImage>()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "干货要来了")
        tableView.addSubview(refresh)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //        var p = Parser()
        //        p.getData(parseUlr)
        //        tableData = p.parserDatas
        
    }
    //    override func viewWillAppear(animated: Bool) {
    //        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
    //        refresh.attributedTitle = NSAttributedString(string: "干货要来了")
    //        tableView.addSubview(refresh)
    //        self.tableView.showsVerticalScrollIndicator = false
    //        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    //        var p = Parser()
    //        p.getData(parseUlr)
    //        tableData = p.parserDatas
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //刷新数据
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUlr)
        tableData = p1.parserDatas
        self.refresh.endRefreshing()
        self.tableView.reloadData()
    }
    
    //跳转准备
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mhsegue" {
            let controller = segue.destinationViewController as ContentViewController
            self.delegate = controller
            //controller.migoo =
        }
    }
    
    //tableView中数据的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //tableView的节
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //返回数据单元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        
        //设置标题和副标题
        var lbTitle = cell.viewWithTag(1) as UILabel
        var lbTime = cell.viewWithTag(2) as UILabel
        lbTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lbTitle.numberOfLines = 0
        //资讯发布时间
//        var time = tableData[indexPath.item].pubDate
//        var day = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 5), end: advance(time.startIndex, 7)))
//        var month = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 8), end: advance(time.startIndex, 11)))
//        var year = time.substringWithRange(Range<String.Index>(start:advance(time.startIndex, 12), end: advance(time.startIndex, 16)))
        var author = tableData[indexPath.item].author
        lbTitle.text = tableData[indexPath.item].title
//        lbTime.text = "\(day) \(month) \(year) edit by \(author)"
        lbTime.text = tableData[indexPath.item].pubDate
        
        
        //设置缩略图
        let urlstr = tableData[indexPath.item].enclosure
        let image = self.imageCache[urlstr]
        var vImage = cell.viewWithTag(3) as UIImageView
        if image? != "" {
            let imgUrl = NSURL(string: urlstr)!
            let request: NSURLRequest = NSURLRequest(URL: imgUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if data != nil {
                    let img = UIImage(data: data)
                    vImage.image = img
                    self.imageCache[urlstr] = img
                } else {
                    vImage.image = UIImage(named: "logo.png")
                }
            })
        } else {
            vImage.image = image
        }
        cell.viewWithTag(3)?.alpha = 0.0
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            cell.viewWithTag(3)?.alpha = 1.0
        })
        
    }
    //跳转
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var board = Commen().storyBoard
        //var next = board.instantiateViewControllerWithIdentifier("DetailView") as UIViewController
        //self.presentViewController(next, animated: true, completion: nil)
        //performSegueWithIdentifier("zxsegue", sender: selectName1)
        self.delegate?.passValue(tableData[indexPath.item])
    }
    
}
