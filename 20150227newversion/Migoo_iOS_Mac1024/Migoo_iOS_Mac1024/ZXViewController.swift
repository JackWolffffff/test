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
    var parseUrl = urlzx
    let identifier = "cell"
    
    //缩略图缓存
    var imageCache = Dictionary<String, UIImage>()
    var refresh = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载nib
        var nib = UINib(nibName: "ArticleListCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: identifier)
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        tableView.addSubview(refresh)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        var p = Parser()
        p.getData(parseUrl)
        tableData = p.parserDatas
        if tableData.count == 0 {
            refreshData()
        }
        tableView.reloadData()
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
        
        var time = tableData[indexPath.item].pubDate
        var day = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 5), end: advance(time.startIndex, 7)))
        var month = time.substringWithRange(Range<String.Index>(start: advance(time.startIndex, 8), end: advance(time.startIndex, 11)))
        var year = time.substringWithRange(Range<String.Index>(start:advance(time.startIndex, 12), end: advance(time.startIndex, 16)))
        var author = tableData[indexPath.item].author
        cell.textLabel?.font = UIFont(name: "宋体", size: 14.0)
        cell.textLabel?.text = tableData[indexPath.item].title
        cell.detailTextLabel?.text = "\(day)/\(month)/\(year) edit by \(author)"
        //设置图标
        let url = tableData[indexPath.item].enclosure
        let image = self.imageCache[url]
        //var vImage = cell.imageView?.image
        if image? != nil {
            let imgUrl = NSURL(string: url)
            let request = NSURLRequest(URL: imgUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: { (response:NSURLResponse!, data:NSData!, error:NSError!)
                -> Void in
                if data != nil {
                    cell.imageView?.image = UIImage(data: data)
                    self.imageCache[url] = cell.imageView?.image
                } else {
                    cell.imageView?.image = UIImage(named: "default.png")
                }
            })
        } else {
            cell.imageView?.image = image
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var articleView = storyBoard.instantiateViewControllerWithIdentifier("articleView") as ArticleShowViewController
        articleView.articleContent = tableData[indexPath.item].description
        //隐藏tabbar
        articleView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(articleView, animated:true)
        
    }
    


}
