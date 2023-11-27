//
//  Checker.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.11.2023.
//

import Foundation

protocol LogInViewControllerDelegate: AnyObject {
    
    func checkLoginAndPassword(stringToCheck: String, currenTime: Date) -> Bool
    
}

class Checker {
    
    var delegate: LogInViewControllerDelegate?
    
    static let shared = Checker()
    
    private let login: String = "Aysel1994"
    private let password: String = "{9Z!"
    
    func check(loginPasswordAYSEL30 trierString: String, time: Date) -> Bool {
        
        let checkerString = (login + "\(time.hashValue)" + password)
        
        if trierString == checkerString {
            return true
        } else {
            return false
        }
    }
}

