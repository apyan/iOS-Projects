//
//  FetchController.swift
//  Dex3
//
//  Created by Alvin on 1/30/25.
//

import Foundation
import CoreData

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse, badData
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon() async throws -> [TempPokemon]? {
        // If there are Pokemon data in the CoreData
        if havePokemon() {
            return nil
        }
        
        var allPokemon: [TempPokemon] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "386")
        ]
        
        // Verify if URL is legitimate
        guard let fetchURL = fetchComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Verify if the response is valid
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        // Get the Pokemon array data
        /* results: []
         {
            name
            url
         }
         */
        // [String: Any] refers to "" : Object
        // Verify for bad data
        guard let pokeDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              // [[String: String]] refers to object of multiple strings
                let pokedex = pokeDictionary["results"] as? [[String: String]] else {
            throw NetworkError.badData
        }
        
        for pokemon in pokedex {
            if let url = pokemon["url"] {
                allPokemon.append(try await fetchPokemon(from: URL(string: url)!))
            }
        }
        
        return allPokemon
    }
    
    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let tempPokemon = try JSONDecoder().decode(TempPokemon.self, from: data)
        
        return tempPokemon
    }
    
    private func havePokemon() -> Bool {
        // Check in the background, won't mess with the main thread
        let context = PersistenceController.shared.container.newBackgroundContext()
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        // Specify fetching attribute, of 1 and 386, getting 2 objects
        // predicate, exactly what you want to fetch
        // fetch the id of 1 and 386
        fetchRequest.predicate = NSPredicate(format: "id IN %@", [1, 386])
        
        do {
            let checkPokemon = try context.fetch(fetchRequest)
            
            // Collecting the two Pokemon of id 1 and 386 succeeds
            if checkPokemon.count == 2 {
                return true
            }
        } catch {
            print("Fetch failed: \(error)")
            return false
        }
        
        return false
    }
}
