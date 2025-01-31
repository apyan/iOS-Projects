//
//  SamplePokemon.swift
//  Dex3
//
//  Created by Alvin on 1/30/25.
//

import Foundation
import CoreData

struct SamplePokemon {
    // static allows to be used everywhere
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        // Getting the guarantee Bulbasaur created
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        // [Pokemon], array of Pokemon
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }()
}
