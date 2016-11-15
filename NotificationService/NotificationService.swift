//
//  NotificationService.swift
//  NotificationService
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import UserNotifications
import MobileCoreServices

let flg = 2

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        print("flg: \(flg)")
        NSLog("***** %@", #function)
        
        if flg == 1 {
            
            self.contentHandler = contentHandler
            bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
            
            if let bestAttemptContent = bestAttemptContent {
                // Modify the notification content here...
                bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
                
                contentHandler(bestAttemptContent)
            }
            
        } else {
            
            self.contentHandler = contentHandler
            bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
            print("\n *** ( BEFORE )bestAttemptContent: \(bestAttemptContent)")
            
            // Get image from URL attached to APNs payload. (http://qiita.com/himara2/items/dcfcc30b550c3304d86a)
            if let imageUrl = request.content.userInfo["data"] as? String {
                print("image")
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: URL(string: imageUrl)!, completionHandler: { (data, response, error) in
                    do {
                        if let writePath = NSURL(fileURLWithPath:NSTemporaryDirectory())
                            .appendingPathComponent("tmp.jpg") {
                            try data?.write(to: writePath)
                            
                            if let bestAttemptContent = self.bestAttemptContent {
                                bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
                                
                                bestAttemptContent.userInfo["shouldAlwaysAlertWhileAppIsForeground"] = "YES"
                                print(bestAttemptContent.userInfo)
                                
                                let attachment = try UNNotificationAttachment(identifier: "tiqav2",
                                                                              url: writePath,
                                                                              options: [UNNotificationAttachmentOptionsTypeHintKey:kUTTypePNG])
                                bestAttemptContent.attachments.append(attachment)
                                
                                let movUrl = Bundle.main.url(forResource: "sample", withExtension: "m4v")
                                let attachment2 = try UNNotificationAttachment(identifier: "tiqav",
                                                                              url: movUrl!,
                                                                              options: nil)
                                bestAttemptContent.attachments.append(attachment2)
                                print("\n *** ( AFTER 1 )bestAttemptContent: \(bestAttemptContent)")
                                
                                contentHandler(bestAttemptContent)
                            }
                        } else {
                            // error: writePath is not URL
                            if let bestAttemptContent = self.bestAttemptContent {
                                print("\n *** ( AFTER 2 )bestAttemptContent: \(bestAttemptContent)")
                                contentHandler(bestAttemptContent)
                                
                            }
                        }
                    } catch let error {
                        print("\n *** \(error)")
                        print(error.localizedDescription)
                        // error: data write error or create UNNotificationAttachment error
                        if let bestAttemptContent = self.bestAttemptContent {
                            print("\n *** ( AFTER 3 )bestAttemptContent: \(bestAttemptContent)")
                            contentHandler(bestAttemptContent)
                        }
                    }
                    
                })
                task.resume()
            }
        }
        
        if let _ = request.content.userInfo["mov"] as? String {
            print("mov")
            let movUrl = Bundle.main.url(forResource: "sample", withExtension: "m4v")
            
            if let bestAttemptContent = self.bestAttemptContent {
                bestAttemptContent.title = "\(bestAttemptContent.title) [modified2]"
                
                do {
                    let attachment = try UNNotificationAttachment(identifier: "tiqav",
                                                                  url: movUrl!,
                                                                  options: nil)
                    bestAttemptContent.attachments.append(attachment)
                    print("\n *** ( AFTER 1 )bestAttemptContent: \(bestAttemptContent)")
//                    contentHandler(bestAttemptContent)
                } catch let error {
                    print("\n *** \(error)")
                    print(error.localizedDescription)
                    // error: data write error or create UNNotificationAttachment error
                    if let bestAttemptContent = self.bestAttemptContent {
                        print("\n *** ( AFTER 3 )bestAttemptContent: \(bestAttemptContent)")
//                        contentHandler(bestAttemptContent)
                    }
                }
            }
        }
        
//        contentHandler(bestAttemptContent!)
        
    }
    
    override func serviceExtensionTimeWillExpire() {
        
        print(#function)
        
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}
