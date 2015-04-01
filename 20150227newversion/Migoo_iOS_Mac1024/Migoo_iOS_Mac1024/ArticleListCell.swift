//
//  ArticleListCell.swift
//  Migoo_iOS_Mac1024
//
//  Created by rongjun on 15/3/31.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {

    @IBOutlet weak var aimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var label = UILabel(frame: CGRectMake(0, self.aimage.bounds.height - 30, self.aimage.bounds.width, 30))
        label.text = "mac1024.com"
        aimage.addSubview(label)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
