//
//  Currency.swift
//  LOTRConverter
//
//  Created by Alvin on 1/14/25.
//

import SwiftUI

// CaseIterable converts the values into a Collection
// Identifiable causes each case to be unique, needed for ForEach
enum Currency: Double, CaseIterable, Identifiable {
    // If default, goes from ordinal (0.000, 1.000, 2.000, ...)
    // Default string will be the literal case name, ex. apple -> "apple"
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    // For currency, we need the 'central base currency', hence gold piece
    
    // Added for Identifiable
    // OR var id: Double { rawValue }
    var id: Currency { self }
    
    // Computed Property
    // Computes the value everytime the property is used
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    func convert(amountString: String, currency: Currency) -> String {
        // String to Double conversion
        // guard, prevents crashes, like this for example, what if user inputs something not appropriate for String to Double conversion
        // enforces an 'else' situation to fall back on
        guard let doubleAmount = Double(amountString) else {
            // End the function and return ""
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        // Ensure two decimal places upon String conversion
        return String(format: "%.2f", convertedAmount)
    }
}
