//
//  ViewController.swift
//  NotifExtSmpl01
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import UIKit
import Kingfisher
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var responseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg")!
        
        self.imageView.kf.setImage(with: url)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.setTokenText(_:)),
                                               name: .tokenNotificationKey,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.setResponseText(_:)),
                                               name: .responseNotificationKey,
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .tokenNotificationKey,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .responseNotificationKey,
                                                  object: nil)
    }
    
    @IBAction func lazyLocalPush(_ sender: Any) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Subtitle"
            content.body = "Body"
            content.sound = UNNotificationSound.default()
            content.badge = 10
            
            if let url = Bundle.main.url(forResource: "sample", withExtension: "m4v") {
                let attachment = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
                if let attachment = attachment {
                    content.attachments = [attachment]
                }
            }
            
            // カスタムアクション
            content.categoryIdentifier = "todoCategoryIdentifier"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "FiveSecond",
                                                content: content,
                                                trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    @IBAction func clearBadge(_ sender: Any) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    @objc func setTokenText(_ notification: Notification) {
        guard let tokenText = notification.object as? String else { return }
        
        self.textView.text = tokenText
    }
    
    @objc func setResponseText(_ notification: Notification) {
        guard let responseText = notification.object as? String else { return }
        
        self.responseTextView.text = responseText
    }
}

