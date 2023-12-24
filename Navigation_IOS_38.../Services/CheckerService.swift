//
//  CheckerService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 17.12.2023.
//

import FirebaseAuth
import UIKit

class CheckerService: UserService {
    func currentUser(login: String) -> User? {
        return user
    }
    
    var user = User(login: "Aysel1994", firstName: "Aysel", avatar: UIImage(), status: "живая")
    }

    func loginUser(email: String, password: String, completion: @escaping(Result< UserService, Error>) -> Void) {
        //вход
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
           // if let authResult = authResult {
               // completion(.success(TestUserService(authResult.user) as UserService))
            }
        }
        
   // }
    
    //регистрация
func singUpUser(email: String, password: String, completion: @escaping(Result< UserService ,Error>) -> Void) {
   // Auth.auth().createUser(withEmail: emailTextField, password: passwordField.text!) { user, error in
       // if error == nil {
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      //  override func viewDidLoad() {
        //    super.viewDidLoad()
          //
          //  Auth.auth()!.addStateDidChangeListener() { auth, user in
              //  if user != nil {
              //      self.switchStoryboard()
            //    }
           // }
      //  }
        
        // или вы можете проверить напрямую
        
      //  if Auth.auth().currentUser?.uid != nil {
            
            //user is logged in
            
     //   }else{
            //user is not logged in
     //   }
 //   }
//}
