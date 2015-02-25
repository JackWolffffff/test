//
//  ContentViewController.swift
//  ParseXML
//
//  Created by rongjun on 15/1/5.
//  Copyright (c) 2015 rongjun. All rights reserved.
//

import UIKit
import Foundation

class ContentViewController: UIViewController,PassValue,UIWebViewDelegate{

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
    
    //    var migoo:MigooRSS = MigooRSS()
    //    var contentTitle: String!
    //    var contentAuthor: String!
    //    var contentDescription: String!
    //    var contentTime:String!
    //    var htmlStr:String!
    //    var def = Define()
    //
    //    var mywebview = UIWebView(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height - 60)))
    //
    //
    //    var content: String!
    //    var img_src: String!
    //
    //    func passValue(value: String, value2: String) {
    //        content = value
    //        img_src = value2
    //        content = content.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
    //        content = content.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
    //        content = content.stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
    //        content = content.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
    //        content = content.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
    //        content = content.stringByReplacingOccurrencesOfString("<section", withString: "")
    //        content = content.stringByReplacingOccurrencesOfString("</section>", withString: "")
    //        var cssStyle: String = "div,p {font-size: 165%;text-align:justify;text-indent: 1.2cm; padding-left:10px;padding-right: 15px; word-break:break-all;} li {list-style-type:none} img { width:0%; visible:false} #ss{visible:true; width:90%; margin-bottom:10px;} "
    //        var htmlStr = "<html><header><style>\(cssStyle)</style></header><div><div><img id=ss src=\"\(img_src)\"></div>\(content)</div></html>"
    //        println(htmlStr)
    //        myWebview.scrollView.bounces = false
    //        myWebview.loadHTMLString(htmlStr, baseURL: nil)
    //        //myWebview.loadRequest(NSURLRequest(URL: NSURL(string: content)!))
    //    }
    //
    //    @IBAction func backUp(sender: AnyObject) {
    //        self.dismissViewControllerAnimated(true, completion: nil)
    //    }
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        self.view.addSubview(mywebview)
    //        myWebview.scalesPageToFit = true
    //        //view.addSubview(myWebview)
    //    }
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    //    /*
    //    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //    }
    //    */


}
