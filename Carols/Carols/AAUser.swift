//
//  AAUser.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/23.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation
import SDWebImage

class AAUser: NSObject {
    
    static let userDB = "UserDatabase.sqlite"
    static var _currentUser: AAUser? = nil
    
    var openId: String?
    var nickName: String!
    var sex: Int?
    var language: String?
    var city: String?
    var province: String?
    var country: String?
    var avatorUrl: String!
    
    init(_openId: String?, _nickName: String?,
         _sex: Int?, _language: String?,
         _city: String?, _province: String?,
         _country: String?, _avatorUrl: String?) {
        openId = _openId
        if let name = _nickName {
            nickName = name
        }else {
            nickName = "Not Set"
        }
        sex = _sex
        language = _language
        city = _city
        province = _province
        country = _country
        if let url = _avatorUrl {
            avatorUrl = url
        }else {
            avatorUrl = ""
        }
    }
    
    override init() {
        super.init()
    }
    
    class func currentUser() -> AAUser {
        if let user = _currentUser {
            return user
        }else {
            let temp = AAUser()
            temp.nickName = "not set"
            return temp
        }
    }
}