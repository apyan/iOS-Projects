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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
