//
//  LoginViewController.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SnapKit
import SlideMenuControllerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    let background            = UIImageView()
    let backCover             = UIView()
    let logo                  = UIImageView()
    let logoDescription       = UILabel()
    let userIcon              = UIImageView()
    let lockIcon              = UIImageView()
    let userTextField         = UITextField()
    let passwordTextField     = UITextField()
    let loginDescription      = UILabel()
    let signUpButton          = UIButton()
    let loginButton           = UIButton()
    let thirdDescriptionLabel = UILabel()
    let wechatButton          = UIButton()
    let weboButton            = UIButton()
    var superView             = UIView()
    
    var tenchentOAuth : TencentOAuth!
    var permissions: NSArray!
    
    
    //MARK: - ViewController Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        initUIComponents()
    }
    
    //MARK: - UI
    func initUIComponents() {
        background.frame = superView.frame
        background.image = UIImage(named: "loginBack")
        superView.addSubview(background)
        
        superView.addSubview(logo)
        logo.snp_makeConstraints { (make) in
            make.width.height.equalTo(140)
            make.top.equalTo(61)
            make.centerX.equalTo(superView)
        }
        logo.image = UIImage(named: "Logo-LoginView")
        
        logoDescription.text      = "Carols"
        logoDescription.font      = UIFont.boldSystemFontOfSize(28)
        logoDescription.textColor = UIColor.GlobalRed()
        superView.addSubview(logoDescription)
        logoDescription.snp_makeConstraints { (make) in
            make.centerX.equalTo(logo.snp_centerX)
            make.top.equalTo(logo.snp_bottom)
        }
        
        userTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSForegroundColorAttributeName:UIColor.GlobalGray()])
        userTextField.textColor             = UIColor.GlobalGray()
        userTextField.delegate              = self
        superView.addSubview(userTextField)
        userTextField.snp_makeConstraints { (make) in
            make.top.equalTo(logoDescription.snp_bottom).offset(64)
            make.centerX.equalTo(superView)
            make.width.equalTo(200)
        }
        
        userIcon.image = UIImage(named: "user")
        superView.addSubview(userIcon)
        userIcon.snp_makeConstraints { (make) in
            make.right.equalTo(userTextField.snp_left).offset(-15)
            make.centerY.equalTo(userTextField)
            make.height.width.equalTo(24)
        }
        
        let redLine1 = UIView()
        redLine1.backgroundColor = UIColor.GlobalRed()
        superView.addSubview(redLine1)
        redLine1.snp_makeConstraints { (make) in
            make.top.equalTo(userTextField.snp_bottom).offset(8)
            make.left.equalTo(userIcon.snp_left).offset(-5)
            make.height.equalTo(1.5)
            make.centerX.equalTo(superView)
        }
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.GlobalGray()])
        passwordTextField.textColor             = UIColor.GlobalRed()
        passwordTextField.delegate              = self
        superView.addSubview(passwordTextField)
        passwordTextField.snp_makeConstraints { (make) in
            make.centerX.width.equalTo(userTextField)
            make.top.equalTo(userTextField.snp_bottom).offset(45)
        }
        
        lockIcon.image = UIImage(named: "lock")
        superView.addSubview(lockIcon)
        lockIcon.snp_makeConstraints { (make) in
            make.right.equalTo(passwordTextField.snp_left).offset(-15)
            make.centerY.equalTo(passwordTextField)
            make.height.width.equalTo(userIcon)
        }
        
        let redLine2 = UIView()
        redLine2.backgroundColor = UIColor.GlobalRed()
        superView.addSubview(redLine2)
        redLine2.snp_makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp_bottom).offset(8)
            make.width.centerX.height.equalTo(redLine1)
        }
        
        loginDescription.text      = "New User?"
        loginDescription.textColor = UIColor.GlobalGray()
        loginDescription.font      = UIFont.boldSystemFontOfSize(15)
        superView.addSubview(loginDescription)
        loginDescription.snp_makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp_bottom).offset(15)
            make.right.equalTo(superView.snp_centerX).offset(-3)
        }
        
        signUpButton.setTitle("Sign Up", forState: .Normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        signUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signUpButton.setTitleColor(UIColor.GlobalGray(), forState: .Selected)
        superView.addSubview(signUpButton)
        signUpButton.snp_makeConstraints { (make) in
            make.left.equalTo(superView.snp_centerX).offset(3)
            make.centerY.equalTo(loginDescription)
        }
        
        signUpButton.addTarget(self, action: #selector(LoginViewController.signButtonClicked), forControlEvents: .TouchUpInside)
        
        superView.addSubview(loginButton)
        loginButton.backgroundColor = UIColor.GlobalRed()
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.layer.cornerRadius = 10
        loginButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(superView)
            make.height.equalTo(35)
            make.width.equalTo(119)
            make.top.equalTo(loginDescription.snp_bottom).offset(49)
        }
        
        thirdDescriptionLabel.text      = "Login by"
        thirdDescriptionLabel.textColor = UIColor.GlobalGray()
        superView.addSubview(thirdDescriptionLabel)
        thirdDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(superView)
            make.top.equalTo(loginButton.snp_bottom).offset(44)
        }
        
        let grayLineLeft             = UIView()
        grayLineLeft.backgroundColor = UIColor.grayColor()
        superView.addSubview(grayLineLeft)
        grayLineLeft.snp_makeConstraints { (make) in
            make.right.equalTo(thirdDescriptionLabel.snp_left).offset(-26)
            make.left.equalTo(superView).offset(30)
            make.height.equalTo(1)
            make.centerY.equalTo(thirdDescriptionLabel)
        }
        
        let grayLineRight             = UIView()
        grayLineRight.backgroundColor = UIColor.grayColor()
        superView.addSubview(grayLineRight)
        grayLineRight.snp_makeConstraints { (make) in
            make.left.equalTo(thirdDescriptionLabel.snp_right).offset(26)
            make.right.equalTo(superView).offset(-30)
            make.height.centerY.equalTo(grayLineLeft)
        }
        
        superView.addSubview(wechatButton)
        wechatButton.setBackgroundImage(UIImage(named: "wechat"), forState: .Normal)
        wechatButton.addTarget(self, action: #selector(LoginViewController.wechatLogin), forControlEvents: .TouchUpInside)
        wechatButton.snp_makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(55)
            make.right.equalTo(superView.snp_centerX).offset(-8)
            make.top.equalTo(thirdDescriptionLabel.snp_bottom).offset(36)
        }
        
        superView.addSubview(weboButton)
        weboButton.setBackgroundImage(UIImage(named: "qq"), forState: .Normal)
        weboButton.addTarget(self, action: #selector(LoginViewController.qqLogin), forControlEvents: .TouchUpInside)
        weboButton.snp_makeConstraints { (make) in
            make.height.width.top.equalTo(wechatButton)
            make.left.equalTo(superView.snp_centerX).offset(8)
        }
    }
    
    //MARK: - Button Functions
    func signButtonClicked()  {
        let vc = SingUpViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

extension LoginViewController: WXApiDelegate, TencentSessionDelegate {
    func wechatLogin() {
        if WXApi.isWXAppInstalled() {
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "123"
            WXApi.sendAuthReq(req, viewController: self, delegate: self)
        }else {
            AAAlertViewController.showAlert("失败", message: "本地没有安装微信")
        }
    }
    
    func onResp(resp: BaseResp!) {
        let code = (resp as! SendAuthResp).code
//        let state = (resp as! SendAuthResp).state
        AALog.info(code)
        LoginRequest.getWDUserInfoByCode(code) { (result, error) in
            if (error != nil) {
                AAAlertViewController.showAlert("出错啦", message: error!.localizedDescription)
            }else {
                let screenWidth = UIScreen.mainScreen().bounds.width
                let slideMenuController = SlideMenuController(mainViewController: MainViewController(), leftMenuViewController: LeftSideViewController())
                slideMenuController.changeLeftViewWidth(screenWidth / 1.2)
//                self.presentViewController(slideMenuController, animated: true, completion: nil)
                let rootWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController
                rootWindow?.presentViewController(slideMenuController, animated: true, completion: nil)
            }
        }
    }
    
    func qqLogin() {
        if QQApiInterface.isQQInstalled() {
            tenchentOAuth = TencentOAuth(appId: ThirdPartyLoginModel.QQAPPID, andDelegate: self)
            permissions = NSArray(array: ["get_user_info", "get_simple_userinfo", "add_t"])
            tenchentOAuth.authorize(permissions as [AnyObject], localAppId: ThirdPartyLoginModel.QQAPPID, inSafari: false)
        }else {
            AAAlertViewController.showAlert("失败", message: "本地没有安装QQ")
        }
    }
    
    //MARK: QQ 回调函数
    func tencentDidLogin() {
        if ((tenchentOAuth.accessToken != nil)) {
            tenchentOAuth.getUserInfo()
        }
    }
    
    func getUserInfoResponse(response: APIResponse!) {
        if ( 0 == response.retCode && 0 == response.detailRetCode) {
            AALog.debug(response.jsonResponse)
            //            AAAlertViewController.showAlert("登录成功", message: "用户名为： \n\((response.jsonResponse as! anyObject).)")
        }
    }
    
    func tencentDidNotLogin(cancelled: Bool) {
        AAAlertViewController.showAlert("用户已取消", message: "网络出错，请重试")
    }
    
    func tencentDidNotNetWork() {
        AAAlertViewController.showAlert("出错啦", message: "网络出错，请重试")
    }
}