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
    
    var webview = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height - 60)))
    
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
        contentDescription = contentDescription.stringByReplacingOccurrencesOfString("text-indent: 2em", withString: "text-indent: 0em")
        contentTime = contentTime.substringWithRange(Range<String.Index>(start: advance(contentTime.startIndex, 0), end: advance(contentTime.startIndex, 26)))
        var cssStyle: String = "body{font-family:\"Helvetica\";}div,p {width:\(self.def.screenWidth()-10)px !important; font-size: 95%;text-align:justify; word-break:break-all !important;color:#3e3e3e;margin-left: 0px;} li {list-style-type:none} a {color:black; text-decoration:none}img {width: \(def.screenWidth() - 20)px !important; height:\((self.def.screenWidth()-20)*2/3);visible:true; align:center;} #ss{visible:true; width:\(def.screenWidth() - 15)px; margin-bottom:0px;} .author{font-size:50%;color:#8c8c8c;} iframe{width:\(self.def.screenWidth()-10)px; height:\((self.def.screenWidth()-20)*2/3);}r"
        var fitScreen: String = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /> "
        htmlStr = "<html><header>\(fitScreen)<style>\(cssStyle)</style></header><body><h4>\(contentTitle)</h4><p class=\"author\">编辑：\(contentAuthor)  时间：\(contentTime)</p><div width=\"\(self.def.screenWidth()-10)\">\(contentDescription)</div></body></html>"
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
