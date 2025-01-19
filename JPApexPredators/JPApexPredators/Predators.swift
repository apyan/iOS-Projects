//
//  Predators.swift
//  JPApexPredators
//
//  Created by Alvin on 1/19/25.
//

// Data -> (Manipulation) -> View
// Use class for this kind of leveraging

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        // if - let protects the app fromfaulty scenarios and crashes
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // Snake Case: fruits_apple
                // Camel Case (default): fruitsApple
                
                // Snake Case -> Camel Case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
}
