//
//  ViewController.swift
//  UICollectionController
//
//  Created by rongjun on 15/4/3.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class ViewController:  UICollectionViewFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var acollectionView: UICollectionView!

    func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }


}

