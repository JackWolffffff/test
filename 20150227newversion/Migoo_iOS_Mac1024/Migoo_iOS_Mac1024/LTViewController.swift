//
//  LTViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 14/12/30.
//  Copyright (c) Migoo. All rights reserved.
//


import UIKit

class LTViewController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        println("11")
        var webView = UIWebView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        webView.delegate = self
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.bounces = false
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urllt)!))
        self.view.addSubview(webView)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        var url = webView.request?.URL.absoluteString
        println(url)
    }
    
}
