//
//  NetworkService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 06.12.2023.
//

import Foundation

enum AppConfiguration: String {
    case badRequest = "Плохой запрос"
    case notFound = "не найдено"
    case unauthorized = "самовольный"
    
}

struct NetworkService {
    
    static func request() {}
    
    let url = URL(string: "https://swapi.dev/api/people/8")
    
   static func request(for configuration: AppConfiguration) {}
    
  // let dataTask = URLSession.shared.dataTask(with: request) { data, response,
     //  error in
        
    }
  //  dataTask.resume()
//}
