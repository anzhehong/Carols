//
//  AAUser.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/23.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation
import SDWebImage
import Alamofire
import CoreData
import SwiftyJSON
import MagicalRecord

class AAUser: NSObject {
    
    static let userDB = "UserDatabase.sqlite"
    
    class func setUser(user: JSON) {
        let nickName = user["nickName"]
        let gender = user["gender"]
        let avaotrUrl = user["avatorUrl"]
        let phoneNum = user["phoneNumber"]
        let newUser = User.currentUser()
        
        newUser.nickName = nickName.string
        newUser.avatorUrl = avaotrUrl.string
        newUser.phoneNum = phoneNum.string
        newUser.sex = NSNumber(integer: gender.intValue)
        User.updateUser(newUser)
    }
    

    static let baseUrl = "http://115.28.74.242:8080/Carols/"
    
    class func register(nickname: String, phoneNum: String,
                        pass: String, completion: AAErrorHandler) {
        let url = "\(baseUrl)LogIn/SignUp?username=\(nickname)&password=\(pass)&phoneNumber=\(phoneNum)"
    
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON , headers: nil).responseJSON { (response) in
            if let error = response.result.error {
                completion(error)
            }else {
                let json = JSON(data: response.data!)
                let user = json["user"]
                setUser(user)
                completion(nil)
            }
        }
    }
    
    class func qqLogin(tologinUser: User, completion: AAErrorHandler) {
        let url = "\(baseUrl)LogIn/SignInQQ?openId=\(tologinUser.openId!)&username=\(tologinUser.nickName!)&avatorURL=\(tologinUser.avatorUrl!)&gender=\(tologinUser.sex!.integerValue)"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON , headers: nil).responseJSON { (response) in
            if let error = response.result.error {
                completion(error)
            }else {
                let json = JSON(data: response.data!)
                let user = json["user"]
                setUser(user)
                completion(nil)
            }
        }
    }
    
    class func normalLogin(phone: String, pass: String, completion: AAErrorHandler) {
        let url = "\(baseUrl)/LogIn/SignIn?phonenumber=\(phone)&password=\(pass)"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON , headers: nil).responseJSON { (response) in
            if let error = response.result.error {
                completion(error)
            }else {
                //TODO: 服务器给Error
                let json = JSON(data: response.data!)
                let user = json["user"]
                setUser(user)
                completion(nil)
            }
        }
    }
    
    class func wechatLogin(tologinUser: User, completion: AAErrorHandler) {
        let url = "\(baseUrl)LogIn/SignInWeChat?openId=\(tologinUser.openId!)&username=\(tologinUser.nickName!)&avatorURL=\(tologinUser.avatorUrl!)&gender=\(tologinUser.sex!.integerValue)"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON , headers: nil).responseJSON { (response) in
            if let error = response.result.error {
                completion(error)
            }else {
                let json = JSON(data: response.data!)
                let user = json["user"]
                setUser(user)
                completion(nil)
            }
        }
    }
    
    class func deleteUser(completion: AAErrorHandler) {
        let user = User.MR_findFirst()
        MagicalRecord.saveWithBlockAndWait { (localContext) in
            let temp = user?.MR_inContext(localContext)
            temp?.MR_deleteEntity()
            User._current = nil
            completion(nil)
        }
    }
    
    class func logout(completion: AAErrorHandler) {
        deleteUser { (error) in
            if error == nil {
                completion(nil)
            }else {
                completion(error)
            }
        }
    }
}