//
//  AppDelegate.swift
//  lifeStyle
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 syi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        ShareSDK.registerApp("1df1eaa3d35a7", activePlatforms:[
            SSDKPlatformType.typeSinaWeibo.rawValue,
            SSDKPlatformType.typeWechat.rawValue],
                             onImport: { (platform : SSDKPlatformType) in
                                switch platform
                                {
                                case SSDKPlatformType.typeSinaWeibo:
                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                                case SSDKPlatformType.typeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                default:
                                    break
                                }
                                
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:

                appInfo?.ssdkSetupSinaWeibo(byAppKey: "3181750951",
                                            appSecret : "df4f720d8c7e925a29021e585e79d505",
                                            redirectUri : "http://www.sharesdk.cn",
                                            authType : SSDKAuthTypeBoth)
                
            case SSDKPlatformType.typeWechat:
                
                appInfo?.ssdkSetupWeChat(byAppId: "wx4868b35061f87885", appSecret: "64020361b8ec4c99936c0e3999a9f249")

            default:
                break
            }
            
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

