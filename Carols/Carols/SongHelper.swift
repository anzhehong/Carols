//
//  SongHelper.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/12/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import SDWebImage
import MediaPlayer

class SongHelper {
 
    class func cacheMusicCovorWithMusicEntities(songList:NSArray,currentIndex:Int) {
        let screen =  UIScreen.mainScreen().bounds
        var pre = currentIndex - 1
        var next = currentIndex + 1
        pre = pre < 0 ? 0 : pre
        next = next == songList.count ? songList.count - 1 : next
        let indexArray = NSMutableArray()
        indexArray.addObject(pre)
        indexArray.addObject(next)
        for (index,_) in indexArray.enumerate() {
            
            let imageWidth = "\((screen.width - 70) * 2)"
            let song = songList[index] as! Song
            let url = BaseHandler.imageGet(song.SongImage!, width: imageWidth, height: imageWidth)
            guard  SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url?.absoluteString) != nil else
            {
                SDWebImageDownloader.sharedDownloader().downloadImageWithURL(url, options: .UseNSURLCache, progress: nil, completed: nil)
                return
            }
        }
        
        
    }
    
    class func configNowPlayingInfoCenter (){
        if (NSClassFromString("MPNowPlayingInfoCenter") != nil) {
            let song = PlayViewController.sharedInstance.currentSong
            let audio = AVURLAsset(URL: NSURL(string:song!.SongURL!)! , options: nil)
            let audioDuration = CMTimeGetSeconds(audio.duration)
            let ablumWidth = ( UIScreen.mainScreen().bounds.width - 16 ) * 2
            let imageView = UIImageView(frame: CGRectMake(0, 0, ablumWidth, ablumWidth))
            let placeHolder = UIImage(named: "music_lock_screen_placeholder")
            let URL = BaseHandler.imageGet(song!.SongImage!, width: "\(ablumWidth)", height: "\(ablumWidth)")
            
            imageView.sd_setImageWithURL(URL, placeholderImage: placeHolder, completed: { (image, error, cacheType, iamgeURL) in
                if let theImage = image  {
                 let artWork = MPMediaItemArtwork(image: theImage)
                 imageView.contentMode = .ScaleAspectFill
                 MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle :song!.SongName!,
                 MPMediaItemPropertyArtist:song!.SongArtist!,
                 MPMediaItemPropertyAlbumTitle: PlayViewController.sharedInstance.songTitle!,
                MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
                else
                {
                 let artWork = MPMediaItemArtwork(image:placeHolder!)
                    imageView.contentMode = .ScaleAspectFill
                    MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle :song!.SongName!,
                        MPMediaItemPropertyArtist:song!.SongArtist!,
                        MPMediaItemPropertyAlbumTitle: PlayViewController.sharedInstance.songTitle!,
                        MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
                //TODO:- @()
            })
        }
    }
}