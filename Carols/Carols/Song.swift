//
//  MusicEntity.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Song: BaseEntity {
    
    var SongId:NSNumber?
    var SongName: String?
    var SongURL:String?
    var SongImage:String?
    var SongArtist:String?
    var SongFile:String?
    var liked:Bool?
   
    static let baseUrl = "http://115.28.74.242:8080/Carols/"
    
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
    
    class func getRecommendationSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
             //   result = dic
            }
            else
            {
                
            }
        }
        return result
    }
    
    class func getPopSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
                //   result = dic
            }
            else {
                
            }
        }
        return result
    }
    
    class func getJazzSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
                //   result = dic
            }
            else {
                
            }
        }
        return result
    }
    
    class func getRBSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
                //   result = dic
            }
            else {
                
            }
        }
        return result
    }
    
    class func getAllSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
                //   result = dic
            }
            else {
                
            }
        }
        return result
    }
    
    class func getHisory(user:String) ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let json = JSON(data: response.data!)
                let dic = json["Songs"]
                print(dic)
                //   result = dic
            }
            else
            {
                
            }
        }
        return result
    }

    

    
}