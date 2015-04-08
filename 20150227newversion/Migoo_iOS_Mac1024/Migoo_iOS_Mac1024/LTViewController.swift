//
//  LTViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 14/12/30.
//  Copyright (c) Migoo. All rights reserved.
//


import UIKit

class LTViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView:UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(string: urllt)!
        var request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var str = webView.request?.URL.absoluteString
        println(str)
        return true
    }
    
}
