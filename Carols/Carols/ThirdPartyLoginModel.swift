//
//  ThirdPartyLoginModel.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/22.
//  Copyright © 2016年 TAC. All rights reserved.
//

class ThirdPartyLoginModel {
    
    static let SHARESDKKEY = "11e33ec7d5085"
    static let QQAPPID = "1105278705"
    static let QQAPPKEY = "aRJ8TPrFyzxxTjJP"
    static let WECHATAPPID = "wx5658c4cff847ff2e"
    static let WECHATSECRET = "76e273a08f154372c6b7cfa2052cdd55"
    
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
}
