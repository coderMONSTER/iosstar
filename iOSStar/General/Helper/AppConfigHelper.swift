//
//  AppConfigHelper.swift
//  iOSStar
//
//  Created by J-bb on 17/5/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD

class AppConfigHelper: NSObject {
    private static var helper = AppConfigHelper()
    class func shared() -> AppConfigHelper {
        
        return helper
    }
    
    func setupNIMSDK(sdkConfigDelegate:NTESSDKConfigDelegate?) {
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
        
        setupReceiveMatching()
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true//0d0f4b452de9695f91b0e4dc949d54cc
        //9c3a406f233dea0d355c6458fb0171b8
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)
        
        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        
    }

    
  
    func share(type:UMSocialPlatformType, shareObject:UMShareWebpageObject, viewControlller:UIViewController) {
        
        let messageObject = UMSocialMessageObject()

        messageObject.shareObject = shareObject


        UMSocialManager.default().share(to: type, messageObject: messageObject, currentViewController: viewControlller) { (data, error) in
            
            
        }
        
    }
    
    func setupUMSDK() {
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "592fbfb09f06fd64b0001fdb"
//        UMSocialManager.default().umSocialAppSecret = ""
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wx9dc39aec13ee3158", appSecret: "a12a88f2c4596b2726dd4ba7623bc27e", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "www.baidu.com")

    }
    
    func setupRealmConfig() {
        
        
    }
    
    func setupReceiveMatching() {
        AppAPIHelper.dealAPI().setReceiveMatching { (response) in
            SVProgressHUD.showSuccess(withStatus: "收到通知")
        }
        
    }
}
