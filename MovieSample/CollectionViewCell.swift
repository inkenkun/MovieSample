//
//  CollectionViewCell.swift
//  MovieSample
//
//  Created by inkenkun on 2015/05/22.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit


import UIKit

class CollectionViewCell : UICollectionViewCell{
    
    var textLabel : UILabel?
    let img: UIImageView = UIImageView(frame: CGRectMake(0,0,100,100))
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*
        // UILabelを生成.
        textLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        textLabel?.text = "nil"
        textLabel?.backgroundColor = UIColor.whiteColor()
        textLabel?.textAlignment = NSTextAlignment.Center
        
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
        */
        
        let myImage = UIImage(named: "Picture.png")
        img.image = myImage
        img.layer.position = CGPoint(x: 50, y: 50.0)
        self.contentView.addSubview(img)

    }
    
}
