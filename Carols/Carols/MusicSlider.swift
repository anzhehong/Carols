//
//  MusicSlider.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/6/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class MusicSlider: UISlider {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let CircleImg = UIImage(named: "music_slider_circle")
        setThumbImage(CircleImg, forState: .Highlighted)
        setThumbImage(CircleImg, forState: .Normal)
        
    }
    
    override func thumbRectForBounds(bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        var result = super.thumbRectForBounds(bounds, trackRect: rect, value: value)
        result.origin.x -= 10
        result.size.width += 20
        return CGRectInset(result, 10, 10)
    }

}
