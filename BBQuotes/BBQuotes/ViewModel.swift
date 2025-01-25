//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Alvin on 1/23/25.
//

import Foundation

// Observable to the View
// Like treat it like @State property
// Alert the view when something changes
// Main Actor is like the main thread, the most powerful and responsive, ideally for UI
@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    // Partially private, can't set but get
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    // Class requires an initial declaration, unlike struct
    // Every value needs an initial in class
    var quote: Quote
    var character: Char
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // try! is forceful without safety
        // reason is guarantee safety due to file provided locally
        let quoteData = try! Data(contentsOf:
                                    Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf:
                                    Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}
