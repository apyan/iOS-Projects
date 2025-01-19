//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Alvin on 1/19/25.
//

// Decodable is needed for decoding, like decoding JSON to Swift data
struct ApexPredator: Decodable {
    let id: Int
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    // Everything in a Decodable must be Decodable
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}
