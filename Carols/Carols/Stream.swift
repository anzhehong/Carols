//
//  Stream.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import DOUAudioStreamer

 class Stream: NSObject, DOUAudioFile{
    
    var taudioFileURL:NSURL?
    var tempURL:NSURL?
    var cacheURL:NSURL?
   
    @objc func audioFileURL() -> NSURL! {
        return taudioFileURL!
    }
}

