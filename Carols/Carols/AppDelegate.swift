//
//  AppDelegate.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?

    static var rootViewController: UIViewController?
    
    static var _delegate: AppDelegate?
    
    class func sharedAppDelegate() -> AppDelegate {
        if _delegate != nil {
            return _delegate!
        }else {
            return (UIApplication.sharedApplication().delegate as? AppDelegate)!
        }
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        
//        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("\(AAUser.userDB)")
//        MagicalRecord.setLoggingLevel(MagicalRecordLoggingLevel.Off)
//        
//        configQQWeChat()
//        
//        if let _ = User.loggedUser() {
//            let screenWidth = UIScreen.mainScreen().bounds.width
//            let slideMenuController = SlideMenuController(mainViewController: MainViewController(), leftMenuViewController: LeftSideViewController())
//            slideMenuController.changeLeftViewWidth(screenWidth / 1.2)
//            AppDelegate.rootViewController = slideMenuController
//            window?.rootViewController = slideMenuController
//        }else {
//            let loginViewController = LoginViewController()
//            AppDelegate.rootViewController = loginViewController
//            window?.rootViewController = loginViewController
//        }
        
        self.window?.makeKeyAndVisible()
        
        //set statusbar hidden
        application.statusBarHidden = true
        
        return true
    }
    
    //MARK: - 数据库
    func configDB() {
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("MyDatabase.sqlite")
        MagicalRecord.setLoggingLevel(MagicalRecordLoggingLevel.Off)
    }
    
    //MARK: - 第三方登录
    func configQQWeChat() {
        WXApi.registerApp(ThirdPartyLoginModel.WECHATAPPID)
        ShareSDK.registerApp(ThirdPartyLoginModel.SHARESDKKEY, activePlatforms: [SSDKPlatformType.TypeQQ.rawValue], onImport: { (platform) in
            switch platform {
            case SSDKPlatformType.TypeQQ:
                ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
            default:
                break
            }
        }) { (platform, appInfo) in
            switch platform {
            case SSDKPlatformType.TypeQQ:
                appInfo.SSDKSetupQQByAppId(ThirdPartyLoginModel.QQAPPID, appKey: ThirdPartyLoginModel.QQAPPKEY, authType: SSDKAuthTypeBoth)
            default:
                break
            }
        }
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return handleURL(url)
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return handleURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return handleURL(url)
    }
    
    func handleURL(url: NSURL) ->Bool {
        let str = url.absoluteString
        if str.hasPrefix("wx") {
            return WXApi.handleOpenURL(url, delegate: LoginViewController())
        }else {
            return TencentOAuth.HandleOpenURL(url)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: String) -> Bool {
        return extensionPointIdentifier != "com.apple.keyboard-service"
    }
    
}


public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}


public extension UIView {
    
    func startTransitionAnimation () {
        let transition = CATransition()
        transition.duration = 1.0
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionFade
        layer.addAnimation(transition, forKey: nil)
    }
    
    func heartAnimation()  {
        var options = UIViewAnimationOptions()
        options.insert(UIViewAnimationOptions.CurveEaseInOut)
        options.insert(UIViewAnimationOptions.AllowAnimatedContent)
        options.insert(UIViewAnimationOptions.BeginFromCurrentState)
        
        UIView.animateWithDuration(0.15, delay: 0, options: options, animations: {
            self.layer.setValue(0.80, forKey: "transform.scale")
            })
        { (finished) in
            UIView.animateWithDuration(0.15, delay: 0, options: options, animations: {
                self.layer.setValue(1, forKey: "transform.scale")
                }, completion: nil)
        }
    }
}


