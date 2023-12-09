//
//  Planet.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 08.12.2023.
//

import Foundation
//Задание 2
struct Planets: Decodable {
    let planets: [Planet]
    
    private enum CodingKeys: String, CodingKey {
        case planets = ""
    }
}

struct Planet: Decodable {
    let name: String
    let rotation_period: Int?
    let orbital_period: Int?
    let diameter: Int?
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: Int?
    let population: Int?
    let created: String
    let edited: String
    let url: String
    let residents: [ URL ]
}

//    private enum CodingKeys: String, CodingKey {
//        typealias RawValue = String
//        case name = "Tatooine"
//        case rotation_period = "23"
//        case orbital_period = "304"
//        case diameter = "10465"
//        case climate = "arid"
//        case gravity = "1 standard"
//        case terrain = "desert"
//        case surface_water = "1"
//        case population = "200000"
//        case created = "2014-12-09T13:50:49.641000Z"
//        case edited = "2014-12-20T20:58:18.411000Z"
//        case url = "https://swapi.dev/api/planets/1/"
        
        // case residents = ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/2/", "https://swapi.dev/api/people/4/", //"https://swapi.dev/api/people/6/", "https://swapi.dev/api/people/7/",  "https://swapi.dev/api/people/8/", //"https://swapi.dev/api/people/9/",  "https://swapi.dev/api/people/11/",  "https://swapi.dev/api/people/43/",    //"https://swapi.dev/api/people/62/"]
        //  case films = ["https://swapi.dev/api/films/1/",
        //  "https://swapi.dev/api/films/3/",
        //  "https://swapi.dev/api/films/4/",
        //  "https://swapi.dev/api/films/5/",
        //  "https://swapi.dev/api/films/6/"
        // ]
//    }
    
//    init(from decoder: Decoder) throws {
        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//       // return
//
//        func decode<T: Decodable>(_ type: T.Type, from: Data) {
//
//        }

//    }
    
//}
