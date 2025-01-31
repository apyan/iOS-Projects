//
//  TempPokemon.swift
//  Dex3
//
//  Created by Alvin on 1/27/25.
//

import Foundation

// Help transition fetch data to core data
struct TempPokemon: Codable {
    let id: Int
    let name: String
    let types: [String]
    var hp = 0
    var attack = 0
    var defense = 0
    var specialAttack = 0
    var specialDefense = 0
    var speed = 0
    let sprite: URL
    let shiny: URL
    
    // Help translate from JSON from 'levels down', like 'object within an object'
    // Sample: https://pokeapi.co/api/v2/pokemon/1/
    // Must match the JSON from API call
    enum PokemonKeys: String, CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
        
        enum StatsDictionaryKeys: String, CodingKey {
            case value = "base_stat"
            case stat
            
            enum StatKeys: String, CodingKey {
                case name
                
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
            case shiny = "front_shiny"
        }
    }
    
    init(from decoder: Decoder) throws {
        // Container contains the JSON object data
        // Using PokemonKeys to match up with the attributes from the JSON data
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var decodeTypes: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        // While not done looping through, at the end of it
        while !typesContainer.isAtEnd {
            let typesDictionaryContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.self)
            let typeContainer = try typesDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.TypeKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            decodeTypes.append(type)
        }
        types = decodeTypes
        
        var statsContainer = try container.nestedUnkeyedContainer(forKey: .stats)
        while !statsContainer.isAtEnd {
            let statsDictionaryContainer = try statsContainer.nestedContainer(keyedBy: PokemonKeys.StatsDictionaryKeys.self)
            let statContainer = try statsDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.StatsDictionaryKeys.StatKeys.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name) {
            case"hp":
                hp = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case"attack":
                attack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case"defense":
                defense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case"special-attack":
                specialAttack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case"special-defense":
                specialDefense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case"speed":
                speed = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            default:
                print("Assume unreachable")
            }
        }
        
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
        shiny = try spriteContainer.decode(URL.self, forKey: .shiny)
    }
}
