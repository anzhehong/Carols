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
    
    var SongId:String?
    var SongName: String?
    var SongURL:String?
    var SongImage:String?
    var SongArtist:String?
    var SongFile:String? = "1770059653_2050944_l"
    var SongLyrics:String?
    var liked:Bool?
   
    static let baseUrl = "http://localhost:8080/Main/"
    
    override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["SongId":"track_id",
                "SongName":"track_name",
                "SongURL":"oringinal_url",
                "SongImage":"album_image",
                "SongArtist":"artist_name",
                "SongLyrics":"lyrics"
            ]
    }
    
    class func parseJson(json:JSON) -> Song {
        let song = Song()
        song.SongId = json["track_id"].string
        song.SongName = json["track_name"].string
        song.SongURL = json["oringinal_url"].string
        song.SongImage = json["album_image"].string
        song.SongArtist = json["artist_name"].string
        song.SongLyrics = json["lyrics"].string
        song.liked = false
        return song
    }
    
    class func getSongsByStarName(artist: String,completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)SongsByStarName?artistName=\(artist)"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
            
        }
    }
    
    class func getSongBySongName(songname:String,completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)SongsBySongName?name=\(songname)"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
            
        }
    }
    
    class func getSongByTag(tag:String,completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)SongsByTagName?name=\(tag)"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
            
        }
    }
    
    class func getAllSongRank(completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)getAllRank?limit=10"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
            
        }
    }

    
    class func getHistory(userId:String,completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)getRecommendByUserId?userId=\(userId)"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
            
        }
    }
    
    class func getRecommendation(userid:String,completion:(([Song]?,NSError?)-> Void)) {
        let url = "\(baseUrl)getRecommendByUserId?userId=\(userid)"
        var songs = [Song]()
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                let jsons = JSON(data: response.data!)["songs"].array
                for json in jsons! {
                    let song = parseJson(json)
                    songs.append(song)
                }
                completion(songs,nil)
            }
            else {
                completion(nil,response.result.error)
            }
        }
    }
    
    class func saveHistory(userId:String,completion:((String?,NSError?)-> Void)) {
        let url = "\(baseUrl)getRecommendByUserId?userId=\(userId)"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON
         {(response) in
                if response.result.error == nil {
                    let message = JSON(data: response.data!)["message"].stringValue
                    completion(message,nil)
                }
                else {
                    completion(nil,response.result.error)
                }
        }
    }
}