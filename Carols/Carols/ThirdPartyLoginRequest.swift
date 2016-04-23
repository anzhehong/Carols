//
//  ThirdPartyLoginRequest.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/23.
//  Copyright © 2016年 TAC. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LoginRequest {
    
    class func getWDUserInfoByCode(code: String, handler: AAUserHandler) {
        let getTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(ThirdPartyLoginModel.WECHATAPPID)&secret=\(ThirdPartyLoginModel.WECHATSECRET)&code=\(code)&grant_type=authorization_code"
        Alamofire.request(.GET, getTokenUrl, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            AALog.debug("response")
            if let error =  response.result.error {
                handler(nil, error)
            }else {
                let json = JSON(data: response.data!)
                let token = json["access_token"]
                let url = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=OPENID&lang=zh_CN"
                Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
                    if let error = response.result.error {
                        handler(nil, error)
                    }else {
                        let result = JSON(data: response.data!)
                        let model = ThirdPartyLoginModel(_openId: result["openid"].string, _nickName: result["nickname"].string, _sex: result["sex"].int, _language: result["language"].string, _city: result["city"].string, _province: result["province"].string, _country: result["country"].string, _avatorUrl: result["headimgurl"].string)
                        handler(model, nil)
                    }
                }

            }
        }
    }
    
}