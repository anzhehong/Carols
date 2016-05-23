//
//  MusicIndicator.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/6/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import NAKPlaybackIndicatorView

class MusicIndicator: NAKPlaybackIndicatorView {
    static let sharedInstance = MusicIndicator()
    
    private init(){
        super.init(frame: CGRectZero)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
