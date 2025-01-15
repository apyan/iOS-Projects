//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Alvin on 1/6/25.
//

import SwiftUI

struct ExchangeInfo: View {
    // Wrapper that reads the view's environment, change the state of the view
    // access throughout the app
    // Dismiss current presentation
    // Evironment properties is always var
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background Image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Title Text
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                // Description Text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                
                // Exchange Rates
                ExchangeRate(
                    leftImage: .goldpiece,
                    exchangeText: "1 Gold Piece = 4 Gold Pennies",
                    rightImage: .goldpenny
                )
                
                ExchangeRate(
                    leftImage: .goldpenny,
                    exchangeText: "1 Gold Penny = 4 Silver Pieces",
                    rightImage: .silverpiece
                )
                
                ExchangeRate(
                    leftImage: .silverpiece,
                    exchangeText: "1 Silver Piece = 4 Silver Pennies",
                    rightImage: .silverpenny
                )
                
                ExchangeRate(
                    leftImage: .silverpenny,
                    exchangeText: "1 Silver Penny = 100 Copper Pennies",
                    rightImage: .copperpenny
                )
                
                // Done Button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            // Covers both light and dark mode/appearance
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}
