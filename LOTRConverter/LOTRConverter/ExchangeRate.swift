//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Alvin on 1/9/25.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let exchangeText: String
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
            // Left Currency Image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Exchange Rate Text
            Text(exchangeText)
            
            // Right Currency Image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(
        leftImage: .silverpiece,
        exchangeText: "1 Silver Piece = 4 Silver Pennies",
        rightImage: .silverpenny
    )
}
