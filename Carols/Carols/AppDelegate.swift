//
//  AppDelegate.swift
//  Carols
//
//  Created by FOWAFOLO on 16/4/1.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: 第三方登录
        configQQWeChat()
        
        let loginViewController = LoginViewController()
        window?.rootViewController = loginViewController
        
//        let mainViewController = MainViewController()
//        window?.rootViewController = mainViewController

        let screenWidth = UIScreen.mainScreen().bounds.width
        let mainViewController = MainViewController()
        let leftViewController = LeftSideViewController()
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        slideMenuController.changeLeftViewWidth(screenWidth / 1.2)
//        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        //set statusbar hidden
        application.statusBarHidden = true
        
        return true
    }
    
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


}

