//
//  Char.swift
//  BBQuotes
//
//  Created by Alvin on 1/23/25.
//

import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    // Swift comes with built-in converter for String to URL
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    // The ? will automatically set it to nil (null), hence var is needed to change
    var death: Death?
    
    // Text(myName ?? "Unknown"), if myName is an Optional, myName?
    // Text(myName!), forcefully use it, force unwrapping
    // if let newProperty = myName { ... }
    // guard let newProperty = myName else { ... }
    
    // Concurrency = running more than one computing task at the same time
    // UI should be the fastest priority
    
    // async, tell app that function might take a while to run, hence change 'lanes'
    // func unwrapGift() async { ... }
    // hence await, a sibling word to async
    // await friend.unwrapGift(), tell other functions and code to happen while this function isn't finished yet
    
    // Automatically provided but hidden
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
        //case death
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        // Edited with sample data
        //self.death = try container.decodeIfPresent(Death.self, forKey: .death)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        // Can eliminate ! from try since the whole function 'throws'
        let deathData = try Data(contentsOf:
                                    Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try! deathDecoder.decode(Death.self, from: deathData)
    }
}
