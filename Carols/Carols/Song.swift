//
//  MusicEntity.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

class Song: BaseEntity {
    
    var SongId:NSNumber?
    var SongName: String?
    var SongURL:String?
    var SongImage:String?
    var SongArtist:String?
    var SongFile:String?
    var liked:Bool?
   
    //TODO:- Change JSON Format to Your Own Format
    override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["SongId":"id",
                "SongName":"title",
                "SongURL":"music_url",
                "SongImage":"pic",
                "SongArtist":"artist",
                "SongFile":"file_name",
            ]
    }
    
}