//
//  BaseTabBarController.swift
//  iosblackcard
//
//  Created by J-bb on 17/4/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController ,UITabBarControllerDelegate,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate{

    var showRed : Bool = false
    
    var sessionUnreadCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initcustomer()
        
    }
    
    func onSystemNotificationCountChanged(_ unreadCount: Int) {
        print(unreadCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func initcustomer(){
        delegate = self
        
        let storyboardNames = ["News","Market","Exchange","User"]
        let titles = ["首页","行情","星聊","个人中心"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])_unselect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])_selected")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(hexString: AppConst.Color.titleColor)], for: .selected)
            addChildViewController(controller!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccess(_:)), name: Notification.Name(rawValue:AppConst.loginSuccess), object: nil)
    }
    
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {

//       self.tabBar.showshowBadgeOnItemIndex(index: 2)
         self.sessionUnreadCount = totalUnreadCount
         self.refreshSessionBadge()
    }
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
         self.sessionUnreadCount = totalUnreadCount
         self.refreshSessionBadge()
//         self.tabBar.showshowBadgeOnItemIndex(index: 2)
    }
    
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        // self.tabBar.hideBadgeOnItemIndex(index: 2)
        self.sessionUnreadCount = totalUnreadCount;
        self.refreshSessionBadge()
        
    }
    
    func allMessagesDeleted() {
        // self.tabBar.hideBadgeOnItemIndex(index: 2)
        self.sessionUnreadCount = 0
        self.refreshSessionBadge()
    }
    
    func LoginSuccess(_ LoginSuccess : NSNotification){
        
        NIMSDK.shared().systemNotificationManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
//        if NIMSDK.shared().conversationManager.allUnreadCount() != 0 {
//            self.tabBar.showshowBadgeOnItemIndex(index: 2)
//        } else {
//            self.tabBar.hideBadgeOnItemIndex(index: 2)
//        }
        print("====\(self.sessionUnreadCount)")
        self.refreshSessionBadge()
    }
    
    // 刷新是否显示红点
    func refreshSessionBadge() {
        if self.sessionUnreadCount == 0 {
            self.tabBar.hideBadgeOnItemIndex(index: 2)
        } else {
            self.tabBar.showshowBadgeOnItemIndex(index: 2)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex == 2  || tabBarController.selectedIndex == 3{

            if  checkLogin(){
            
            }
        }
    }
}
