//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by Alvin on 2/5/25.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    // Let it exist throughout the entire app
    @StateObject private var store = Store()
    @StateObject private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(game)
                .task {
                    // Load up the products so they can be ready to be purchased
                    await store.loadProducts()
                }
        }
    }
}
