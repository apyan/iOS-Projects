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
        
    }
}
