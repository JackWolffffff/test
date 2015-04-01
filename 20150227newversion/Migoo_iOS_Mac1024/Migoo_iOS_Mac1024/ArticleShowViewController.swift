//
//  ArticleShowViewController.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/2/27.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class ArticleShowViewController: UIViewController, UIWebViewDelegate{
    var migoo:MigooRSS = MigooRSS()
    var contentTitle: String!
    var contentAuthor: String!
    var contentDescription: String!
    var contentTime:String!
    var htmlStr:String!
    var def = Define()
    
    var webview = UIWebView(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height - 60)))
    
    func passValue(content:MigooRSS) {
        migoo = content
        contentDescription = migoo.description
        contentTitle = migoo.title
        contentAuthor = migoo.author
        contentTime = migoo.pubDate
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<section", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</section>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<ignore_js_op>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</ignore_js_op>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<strong>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</strong>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<li>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</li>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<ol>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</ol>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("<ul>", withString: "")
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("</ul>", withString: "")
        contentTime = contentTime.substringWithRange(Range<String.Index>(start: advance(contentTime.startIndex, 0), end: advance(contentTime.startIndex, 26)))
        var cssStyle: String = "body{font-family:\"Helvetica\";}div,p {font-size: 95%;text-align:justify; word-break:break-all !important;color:#3e3e3e; } li {list-style-type:none} a {color:black; text-decoration:none}img { max-width: 100%; max-height:60%;visible:true;} #ss{visible:true; width:\(def.screenWidth() - 10)px; margin-bottom:10px;} .author{font-size:50%;color:#8c8c8c;} iframe{width:100%; height:auto;} "
        var fitScreen: String = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /> "
        htmlStr = "<html><header>\(fitScreen)<style>\(cssStyle)</style></header><h4>\(contentTitle)</h4><p class=\"author\">编辑：\(contentAuthor)  时间：\(contentTime)</p><div>\(contentDescription)</div></html>"
        println(htmlStr)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webview)
        self.passValue(migoo)
        webview.scrollView.bounces = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.scrollView.showsVerticalScrollIndicator = true
        webview.loadHTMLString(htmlStr, baseURL: nil)
    }
    @IBAction func backWard(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        webview.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none';")
    }
}
