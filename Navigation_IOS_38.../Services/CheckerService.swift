//
//  CheckerService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 17.12.2023.
//

import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> ()))
    func checkCredentials(email: String, password: String, completion: @escaping ((Bool) -> ()))
}

final class CheckerService: CheckerServiceProtocol {
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> ())) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                return completion(false)
            }
            
            return completion(true)
        }
    }
    
    func checkCredentials(email: String, password: String, completion: @escaping ((Bool) -> ())) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                return completion(false)
            }
            
            return completion(true)
        }
    }
}

