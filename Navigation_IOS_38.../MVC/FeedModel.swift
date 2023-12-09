//
//  FeedModel.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 04.12.2023.
//

import Foundation

//модель
final class FeedModel {
    
    let notificationCenter = NotificationCenter.default
    private let secretWord: String = "Conditional password"
    
    init() {}
    
    func check(word: String) {
        
        var notification = Notification(
            name: NSNotification.Name(rawValue: "Clear notification"),
            object: nil,
            userInfo: nil)
        
        if word == secretWord {
            notification.name = NSNotification.Name(rawValue: "Word is correct")
        } else {
            notification.name = NSNotification.Name(rawValue: "Word is not correct")
        }
        
        notificationCenter.post(notification)
    }
}
