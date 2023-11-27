//
//  CurrentUserService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.11.2023.
//

import UIKit

class CurrentUserService {
    static var shared: CurrentUserService = CurrentUserService()
    
    private init() {
        user = User(login: "Aysel1994", firstName: "Aysel", avatar: UIImage(), status: "живая")
    }
    
    private var user: User
}



extension CurrentUserService: UserService {
    
    func currentUser(login: String) -> User? {
        if login == user.login {
            return user
        }
        
        return nil
    }
}
