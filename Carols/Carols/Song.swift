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
    var SongFile:String? = "1770059653_2050944_l"
    var SongLyrics:String?
    var liked:Bool?
   
    static let baseUrl = "http://localhost:8080/Main/"
    
    //TODO:- Change JSON Format to Your Own Format
    override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["SongId":"track_id",
                "SongName":"track_name",
                "SongURL":"oringinal_url",
                "SongImage":"album_image",
                "SongArtist":"artist_name",
                "SongLyrics":"lyrics"
            ]
    }
    
    class func getRecommendationSongs(userId:String) ->[Song]{
        let url = "\(baseUrl)getRecommendByUserId?userId=\(userId)"
        let result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
            }
            else
            {
               print(response.result.error)
            }
        }
        return result
    }
    
    class func getPopSongs() ->[Song]{
        let url = "\(baseUrl)SongsByTagName?name=pop"
        let result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
            }
            else {
                print(response.result.error)
            }
        }
        return result
    }
    
    class func getJazzSongs() ->[Song]{
        let url = "\(baseUrl)SongsByTagName?name=jazz"
        let result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
            }
            else {
                print(response.result.error)
            }
        }
        return result
    }
    
    
    class func getHisory(user:String) ->[Song]{
        let url = "\(baseUrl)getHistory?userId=\(user)"
        let result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
                print("-----test")
            }
            else
            {
                print(response.result.error)
            }
        }
        return result
    }
    
    class func saveHistory(user:String,trackId:String) ->Bool {
        let url = "\(baseUrl)recordHistory?userId=\(user)&trackId=\(trackId)"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
            }
            else
            {
                print(response.result.error)
            }
        }
        return true
    }
    
//TODO:- Need
    class func getRBSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
            }
            else {
                print(response.result.error)
            }
        }
        return result
    }
//TODO:- Need
    class func getAllSongs() ->[Song]{
        let url = baseUrl
        var result = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let result = try! NSJSONSerialization.JSONObjectWithData(response.data!, options:.MutableContainers) as! NSDictionary
                let array = result["songs"]!.mutableCopy() as! NSArray
                let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
                print(mutableArray)
            }
            else {
                print(response.result.error)
            }
        }
        return result
    }

    
}