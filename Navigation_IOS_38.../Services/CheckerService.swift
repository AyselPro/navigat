//
//  CheckerService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 17.12.2023.
//

import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    // Теперь возвращаем не Bool, а опционального пользователя, если все успешно
    func signUp(email: String, password: String, completion: @escaping ((User?) -> ()))
    // Теперь возвращаем не Bool, а опционального пользователя, если все успешно
    func checkCredentials(email: String, password: String, completion: @escaping ((User?) -> ()))
}

final class CheckerService: CheckerServiceProtocol {
    func signUp(email: String, password: String, completion: @escaping ((User?) -> ())) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil, let firebaseUser = result?.user else {
                return completion(nil)
            }
            
            let user = User(
                login: firebaseUser.email ?? "",
                firstName: firebaseUser.displayName ?? "",
                avatar: UIImage(),
                status: "alive"
            )
            
            return completion(user)
        }
    }
    
    func checkCredentials(email: String, password: String, completion: @escaping ((User?) -> ())) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil, let firebaseUser = result?.user else {
                return completion(nil)
            }
            
            let user = User(
                login: firebaseUser.email ?? "",
                firstName: firebaseUser.displayName ?? "",
                avatar: UIImage(),
                status: "alive"
            )
            
            return completion(user)
        }
    }
}
