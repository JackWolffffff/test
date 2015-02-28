//
//  Define.swift
//  Root
//
//  Created by rongjun on 14/12/30.
//  Copyright (c) Migoo. All rights reserved.
//


// 7 以上

import UIKit

class Define:NSObject {
    
    // 设备系统版本
    func ifIOS7()->Bool{
        
        let t =  UIDevice.currentDevice()
        let v = t.systemVersion
        let arr:NSArray = v.componentsSeparatedByString(".")
        let num : AnyObject! = arr[0]
        let Num:CInt = num.intValue
        
        if Num >= 7 {
            return true
        }else{
            return false
        }
    }
    
    
    // 获取设备的物理高度
    func screenHeight()->CGFloat {
        
        let main = UIScreen.mainScreen()
        
        var rect = main.bounds
        var height = rect.height
        return height
    }
    
    // 获取设备的物理高度
    func screenWidth()->CGFloat {
        let main = UIScreen.mainScreen()
        var rect = main.bounds
        var width = rect.width
        return width
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}