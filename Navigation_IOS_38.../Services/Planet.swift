//
//  Planet.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 08.12.2023.
//

import Foundation
//Задание 2

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
    let created: Date?
    let edited: Date?
    let url: URL
    let residents: URL
    let films: URL
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case rotation_period
        case orbital_period
        case diameter
        case climate
        case gravity
        case terrain
        case surface_water
        case population
        case created
        case edited
        case url
        case residents
        case films
    }
    
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try! container.decode(String.self, forKey: .name)
        self.rotation_period = try! container.decode(Int.self, forKey: .rotation_period)
        self.orbital_period = try! container.decode(Int.self, forKey: .orbital_period)
        self.diameter = try! container.decode(Int.self, forKey: .diameter)
        self.climate = try! container.decode(String.self, forKey: .climate)
        self.gravity = try! container.decode(String.self, forKey: .gravity)
        self.terrain = try! container.decode(String.self, forKey: .terrain)
        self.surface_water = try! container.decode(Int.self, forKey: .surface_water)
        self.population = try! container.decode(Int.self, forKey: .population)
        self.created = try! container.decode(Date.self, forKey: .created)
        self.edited = try! container.decode(Date.self, forKey: .edited)
        self.url = try! container.decode(URL.self, forKey: .url)
        self.residents = try! container.decode(URL.self, forKey: .residents)
        self.films = try! container.decode(URL.self, forKey: .films)
        
        
        
        
        func decode<T : Decodable>(_ type: T.Type, from data: Data) throws -> T {
            let topLevel: Any
            do {
                topLevel = try JSONSerialization.jsonObject(with: data)
            } catch {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: error))
            }
            
            let decoder = JSONDecoder()
            guard let value = try decoder.unbox(topLevel, as: type) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: "The given data did not contain a top-level value."))
            }
            
            return value
        }
    }
}
    // MARK: - Concrete Value Representations
private extension JSONDecoder {
    
    func unbox<T : Decodable>(_ value: Any, as type: T.Type) throws -> T? {
        return try unbox_(value, as: type) as? T
    }
    
    func unbox_(_ value: Any, as type: Decodable.Type) throws -> Any? {
        return try type.init(from: Planet.self as! Decoder)
        }
    }
