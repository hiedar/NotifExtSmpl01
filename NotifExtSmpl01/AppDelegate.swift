//
//  AppDelegate.swift
//  NotifExtSmpl01
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            // Push通知の設定
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
            UNUserNotificationCenter.current().delegate = self
            
            // Action
            let laterAction = UNNotificationAction(identifier: NotificationAction.later.identifier,
                                                   title: NotificationAction.later.title,
                                                   options:[])
            let replyAction = UNTextInputNotificationAction(identifier: NotificationAction.reply.identifier,
                                                            title: NotificationAction.reply.title,
                                                            options:[],
                                                            textInputButtonTitle: "Send",
                                                            textInputPlaceholder: "input reply text")
            let closeAction = UNNotificationAction(identifier: NotificationAction.close.identifier,
                                                   title: NotificationAction.close.title,
                                                   options:[.destructive])
            let openAction = UNNotificationAction(identifier: NotificationAction.open.identifier,
                                                  title: NotificationAction.open.title,
                                                  options:[.authenticationRequired, .foreground])
            
            // category
            let todoCategory = UNNotificationCategory(identifier: NotificationCategory.todo.identifier,
                                                      actions: [closeAction, laterAction, replyAction, openAction],
                                                      intentIdentifiers: [],
                                                      options: [.customDismissAction])
            
            UNUserNotificationCenter.current().setNotificationCategories([todoCategory])
            
        } else {
            // Fallback on earlier versions
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
    
    // MARK: - Notification
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print(token)
        
        NotificationCenter.default.post(name: .tokenNotificationKey, object: token)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // MARK: - UNNotification Center
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        
        // Display
        completionHandler([.alert, .badge, .sound])
        
        print("\ncontent: \(notification.request.content)")
        
        // Update badge count
        if let badgeCount = notification.request.content.badge {
            print("  -- badge: \(badgeCount)\n")
            UIApplication.shared.applicationIconBadgeNumber = Int(badgeCount)
        } else {
            print("  -- no badge\n")
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        print("\nresponse.actionIdentifier: \(response.actionIdentifier)")
        
        // 入力されたテキストを取得する
        if let textInputResponse = response as? UNTextInputNotificationResponse,
            response.actionIdentifier == NotificationAction.reply.identifier {
            print("userText: \(textInputResponse.userText)")
        }
        
        completionHandler()
    }
    
}

