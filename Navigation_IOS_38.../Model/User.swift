//
//  User.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.11.2023.
//
import FirebaseAuth
import UIKit

protocol UserService {
    func currentUser(login: String) -> User?
}

class User {
    let login: String
    let firstName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, firstName: String, avatar: UIImage, status: String) {
        self.login = login
        self.firstName = firstName
        self.avatar = avatar
        self.status = status
    }
}

