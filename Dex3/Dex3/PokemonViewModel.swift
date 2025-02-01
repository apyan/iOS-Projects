//
//  PokemonViewModel.swift
//  Dex3
//
//  Created by Alvin on 1/30/25.
//

import Foundation

// ObservableObject for published properties for views to watch and get updates from
@MainActor
class PokemonViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    @Published private(set) var status = Status.notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
        
        Task {
            await getPokemon()
        }
    }
    
    private func getPokemon() async {
        status = .fetching
        
        do {
            guard var pokedex = try await controller.fetchAllPokemon() else {
                // Pokemon has already been obtained
                status = .success
                return
            }
            
            // Sort is needed just in case if later calls finish earlier calls
            // Sort by id
            pokedex.sort { $0.id < $1.id }
            
            // Add them to CoreData
            for pokemon in pokedex {
                // Create new object
                let newPokemon = Pokemon(context: PersistenceController.shared.container.viewContext)
                newPokemon.id = Int16(pokemon.id)
                newPokemon.name = pokemon.name
                newPokemon.types = pokemon.types
                newPokemon.organizeTypes()
                
                newPokemon.hp = Int16(pokemon.hp)
                newPokemon.attack = Int16(pokemon.attack)
                newPokemon.defense = Int16(pokemon.defense)
                newPokemon.specialAttack = Int16(pokemon.specialAttack)
                newPokemon.specialDefense = Int16(pokemon.specialDefense)
                newPokemon.speed = Int16(pokemon.speed)
                newPokemon.sprite = pokemon.sprite
                newPokemon.shiny = pokemon.shiny
                newPokemon.favorite = false
                
                // Save the CoreData
                try PersistenceController.shared.container.viewContext.save()
            }
            
            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}
