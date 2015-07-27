//
//  AVPlayerView.swift
//  MovieSample
//
//  Created by inkenkun on 2015/05/22.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import AVFoundation
import UIKit

class AVPlayerView : UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
    
}
