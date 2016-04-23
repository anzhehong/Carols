//
//  AAUser.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/23.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Foundation

class AAUser: NSObject {
    var openId: String?
    var nickName: String?
    var sex: Int?
    var language: String?
    var city: String?
    var province: String?
    var country: String?
    var avatorUrl: String?
    
    init(_openId: String?, _nickName: String?,
         _sex: Int?, _language: String?,
         _city: String?, _province: String?,
         _country: String?, _avatorUrl: String?) {
        openId = _openId
        nickName = _nickName
        sex = _sex
        language = _language
        city = _city
        province = _province
        country = _country
        avatorUrl = _avatorUrl
    }
    
//    class func currentUser() -> AAUser {
//        
//    }
}