//
//  TestUserService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.11.2023.
//

import UIKit

class TestUserService: UserService {
    
    func currentUser(login: String) -> User? {
        return user
    }
    
    var user = User(login: "Aysel1994", firstName: "Aysel", avatar: UIImage(), status: "живая")
}
