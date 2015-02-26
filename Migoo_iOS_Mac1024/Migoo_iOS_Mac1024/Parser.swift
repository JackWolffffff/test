//
//  ZIXUN.swift
//  MigooAPP
//
//  Created by 戎军 on 15/1/9.
//  Copyright (c) 2015年 rongjun. All rights reserved.
//

import UIKit
import Foundation
class  Parser: NSObject,NSXMLParserDelegate {
    
    var currentElement: MigooRSS = MigooRSS()
    var currentNodeName: String = "" //当前节点名称
    var imageCache = Dictionary<String,UIImage>()
    var parserDatas: Array <MigooRSS> = []
    var str:NSString?
    
    func getData(url:String) {
        var urlStr = NSURL(string: url)
        var data = NSData(contentsOfURL: urlStr!)
        
        
        if data != nil {
            println("请求成功")
            var parser = NSXMLParser(data:data)
            parser.delegate = self
            if (parser.parse() != false) {
                println("解析成功")
            } else {
                println("解析失败")
            }
        } else {
            println("请求失败")
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        for var i = 0; i < parserDatas.count; i++ {
            println(parserDatas[i].title);
        }
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        currentNodeName = elementName
        if elementName == "item" {
            currentElement = MigooRSS()
            parserDatas.append(currentElement)
            
        }
        if currentNodeName == "enclosure" {
            currentElement.enclosure = attributeDict["url"]! as String
            println(attributeDict["url"]! as String)
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        var str = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != "" {
            switch currentNodeName {
            case "title" :
                currentElement.title += str
                println(currentElement.title)
            case "link":
                currentElement.link += str
            case "author" :
                currentElement.author += str
            case "pubDate" :
                currentElement.pubDate += str
            case "description" :
                currentElement.description += str
            default: print("")
            }
    }
        
        // println(str)
    }
    
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        println("\(parseError.code.description)")
    }
}