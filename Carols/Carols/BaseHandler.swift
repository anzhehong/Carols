//
//  BaseHandler.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/12/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

class BaseHandler {
    class func imageGet(link:String,width:String,height:String) -> NSURL? {
        var url = ""
        if height == "0" {
            //TODO:- Change Image URL TO YOUR OWN
            url = "\(link)?imageView2/2/w/\(width)/"
        }
        else {
            //TODO:- Change Image URL TO YOUR OWN
            url = "\(link)?imageView/1/w/\(width)/h/\(height)"
        }
        return NSURL(string: url)
    }
    
    class func imageGet(link:String,width:String,height:String,mode:Int) -> NSURL? {
        //TODO:- Change Image URL TO YOUR OWN
        return NSURL(string: "\(link)?imageView/\(mode)/w/\(width)/h/\(height)")
    }
}