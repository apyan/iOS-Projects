//
//  Pokemon+Ext.swift
//  Dex3
//
//  Created by Alvin on 1/30/25.
//

import Foundation

// Extending on the CoreData's Pokemon model
extension Pokemon {
    // Compute the property on the spot
    var background: String {
        switch self.types![0] {
        case "normal", "grass", "electric", "poison", "fairy":
            return "normalgrasselectricpoisonfairy"
        case "rock", "ground", "steel", "fighting", "ghost", "dark", "psychic":
            return "rockgroundsteelfightingghostdarkpsychic"
        case "fire", "dragon":
            return "firedragon"
        case "flying", "bug":
            return "flyingbug"
        case "ice":
            return "ice"
        case "water":
            return "water"
        default:
            return "hi"
        }
    }
    
    // Getting CoreData properties will never be in 'order'
    // So we will have to 'organize/sort' the data ourselves
    var stats: [Stat] {
        [
            Stat(id: 1, label: "HP", value: self.hp),
            Stat(id: 2, label: "Attack", value: self.attack),
            Stat(id: 3, label: "Defense", value: self.defense),
            Stat(id: 4, label: "Special Attack", value: self.specialAttack),
            Stat(id: 5, label: "Special Defense", value: self.specialDefense),
            Stat(id: 6, label: "Speed", value: self.speed)
        ]
    }
    
    var highestStat: Stat {
        stats.max { $0.value < $1.value }!
    }
    
    func organizeTypes() {
        if self.types!.count == 2 && self.types![0] == "normal" {
//            let tempType = self.types![0]
//            self.types![0] = self.types![1]
//            self.types![1] = tempType
            
            self.types!.swapAt(0, 1)
        }
    }
}

// Stat model
struct Stat: Identifiable {
    let id: Int
    let label: String
    let value: Int16
}
