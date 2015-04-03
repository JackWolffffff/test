//
//  LaunchScreen.swift
//  MigooAPP
//
//  Created by 戎军 on 15/1/13.
//  Copyright (c) 2015年 rongjun. All rights reserved.
//

import Foundation

import UIKit

class LaunchScreen: UIViewController,UIScrollViewDelegate {
    var pageControl = UIPageControl()
    var ClickMe = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //scrollview
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().boolForKey("firstStart") {
            
            setFirstOpen()
        } else {
            println(NSUserDefaults.standardUserDefaults().boolForKey("firstStart"))
            turnNextView()
        }
    }
    func setFirstOpen(){
        var scrollview = UIScrollView()
        scrollview.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        scrollview.contentSize = CGSizeMake(self.view.bounds.width * 3, self.view.bounds.height)
        //        scrollview.backgroundColor = UIColor.blueColor()
        //        scrollview.showsHorizontalScrollIndicator = true
        scrollview.scrollEnabled = true
        scrollview.pagingEnabled = true
        scrollview.bounces = false
        view.addSubview(scrollview)
        //image
        var LoadingOne = UIImageView()
        LoadingOne.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        LoadingOne.image = UIImage(named: "引导页one使用.png")
        scrollview.addSubview(LoadingOne)
        
        var LoadingTwo = UIImageView()
        LoadingTwo.frame = CGRectMake(self.view.bounds.width, 0, self.view.bounds.width, self.view.bounds.height)
        LoadingTwo.image = UIImage(named: "two使用.png")
        scrollview.addSubview(LoadingTwo)
        
        var LoadingThree = UIImageView()
        LoadingThree.frame = CGRectMake(self.view.bounds.width * 2, 0, self.view.bounds.width, self.view.bounds.height)
        LoadingThree.image = UIImage(named: "three使用.png")
        scrollview.addSubview(LoadingThree)
        
        //pageControl
        //        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.numberOfPages = 3
        pageControl.tag = 101
        pageControl.frame = CGRectMake(self.view.bounds.width * 0.42, self.view.bounds.height * 0.8, 55, 37)
        pageControl.tintColor = UIColor.whiteColor()
        pageControl.userInteractionEnabled = false
        view.addSubview(pageControl)
        
        scrollview.delegate = self
        
        //页面跳转
        ClickMe.frame = CGRectMake(self.view.bounds.width * 0.35, self.view.bounds.height * 0.67, 100, 100)
        //        ClickMe.backgroundColor = UIColor.whiteColor()
        ClickMe.setImage(UIImage(named: "ClickMe.png"), forState: .Normal)
        view.addSubview(ClickMe)
        ClickMe.addTarget(self, action: "turnNextView", forControlEvents: UIControlEvents.TouchUpInside)
        ClickMe.hidden = true

    }
    //寻找main控件 页面跳转
    func turnNextView(){
        var sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: AnyObject = sb.instantiateViewControllerWithIdentifier("TabBarController") as UITabBarController
        //self.performSegueWithIdentifier("load", sender: self)
        self.presentViewController(vc as UIViewController, animated: true, completion: nil)
    }
    func displayClickMe(){
        if pageControl.currentPage == 2 {
            ClickMe.hidden = false
        }else{
            ClickMe.hidden = true
        }
    }
    
    //减速滑动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var current = (Int)(scrollView.contentOffset.x) / (Int)(self.view.bounds.width)
        pageControl.currentPage = current
        
        displayClickMe()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

