//
//  NotificationActionIdentifiers.swift
//  NotifExtSmpl01
//
//  Created by 檜枝　龍一 on 2016/11/15.
//
//

import Foundation

enum NotificationAction {
    case reply
    case later
    case open
    case close
    
    var identifier: String {
        switch self {
        case .reply:
            return "NotificationActionReply"
        case .later:
            return "NotificationActionLater"
        case .open:
            return "NotificationActionOpen"
        case .close:
            return "NotificationActionClose"
        }
    }
    
    var title: String {
        switch self {
        case .reply:
            return "Reply"
        case .later:
            return "Later"
        case .open:
            return "Open"
        case .close:
            return "Close"
        }
    }
}

enum NotificationCategory {
    case todo
    
    var identifier: String {
        switch self {
        case .todo:
            return "todoCategoryIdentifier"
        }
    }
}
