//
//  VideoViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/4/2.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIAlertViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var aCollectionView: UICollectionView!
    var tableData:Array<MigooRSS> = []
    var parseUrl = urlsp
    var refresh = UIRefreshControl()
    var imageCache = Dictionary<String, UIImage>()
    let def = Define()
    override func viewDidLoad() {
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新内容")
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.aCollectionView.addSubview(refresh)
        self.aCollectionView.showsHorizontalScrollIndicator = false
        self.aCollectionView.showsVerticalScrollIndicator = false
        self.aCollectionView.alwaysBounceVertical = true
        self.aCollectionView.backgroundColor = UIColor.whiteColor()
        //设置navigationBar和tabBar不透明
        self.tabBarController?.tabBar.translucent = false
        self.navigationController?.navigationBar.translucent = false
        self.loadData()
    }
    
    //刷新数据
    func refreshData (){
        var p1 = Parser()
        p1.getData(parseUrl)
        tableData = []
        tableData = p1.parserDatas
        self.refresh.endRefreshing()
        self.aCollectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.layoutMargins.left = 10
        cell.layoutMargins.right = 10
        var imageView = UIImageView(frame: CGRectMake(0, 0, cell.bounds.width, cell.bounds.height))
        var titleLabel = UILabel(frame: CGRectMake(0, imageView.bounds.height - 20, cell.bounds.width, 20))
        titleLabel.backgroundColor = UIColor(red: 0.439, green: 0.757, blue: 0.918, alpha: 0.8)
        if tableData.count > 0 {
            titleLabel.text = tableData[indexPath.item].title
            var url = tableData[indexPath.item].enclosure
            var request = NSURLRequest(URL: NSURL(string: url)!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                if data != nil {
                    imageView.image = UIImage(data: data)
                    imageView.addSubview(titleLabel)
                    cell.addSubview(imageView)
                    //self.imageCache[url] = imageView.image
                } else {
                    println(123)
                }
            })
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var articleView = storyBoard.instantiateViewControllerWithIdentifier("articleView") as ArticleShowViewController
        articleView.migoo = tableData[indexPath.item]
        articleView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(articleView, animated: true)
    }
    
    func loadData(){
        dispatch_async(dispatch_get_global_queue(0, 0), {
            // 处理耗时操作的代码块...
            //请求数据
            var p = Parser()
            if p.getData(self.parseUrl) {
                self.tableData = p.parserDatas
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), {
                    JvHua.setHidden(true)
                    self.aCollectionView.reloadData()
                })
            } else {
                JvHua.setHidden(true)
                var alert = UIAlertView(title: "提示", message: "数据请求失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再试一次")
                alert.show()
            }
            
        })
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(def.screenWidth() / 2 - 20, (def.screenWidth() / 2 - 20) * 2 / 3)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            cell.viewWithTag(3)?.alpha = 1.0
        })
    }
}
