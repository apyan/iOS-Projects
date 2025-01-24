//
//  FetchService.swift
//  BBQuotes
//
//  Created by Alvin on 1/23/25.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // async, unknown for the time completion, hence runs in background
    // throws deals with potentially thrown errors
    // whereas, try catchs the potential errors
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch URL
        // appending() applies "/" already
        let quoteURL = baseURL.appending(path: "quotes/random")
        
        // appending() applies "?" already
        let fetchURL = quoteURL.appending(queryItems: [
            URLQueryItem(name: "production", value: show)
        ])
        
        // Fetch data
        // Tuple, more than one property or value in one result
        // ex. func serveDinner() -> (Food, Drink) { ... }
        // built-in networking function
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        // Checks if good (200), else throws bad response error
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        let characterURL = baseURL.appending(path: "characters")
        
        let fetchURL = characterURL.appending(queryItems: [
            URLQueryItem(name: "name", value: name)
        ])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // THis is because the API has given an array of characters
        let characters = try decoder.decode([Char].self, from: data)
        
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if (death.character == character) {
                return death
            }
        }
        
        return nil
    }
    
    // Model (Data Structure)
    
    // Controller (Manipulate Data)
    
    // ViewModel (Manipulate Data)
    // Observable to the view
    
    // View (Screen)
}
