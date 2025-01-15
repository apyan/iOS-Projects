//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Alvin on 1/9/25.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @State var currency: Currency
    
    var body: some View {
        ZStack {
            // Parchment Background Image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // Currency Icons
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    // (0...4) can work for 0-4, but ForEach cannot accept ClosedRange
                    ForEach(Currency.allCases) { currency in
                        // Change variable name is also viable
                        // self.currency grabs the outer scope
                        if (self.currency == currency) {
                            CurrencyIcon(
                                currencyImage: currency.image,
                                currencyName: currency.name
                            )
                            .shadow(color: .black, radius: 10)
                            // Adds above the object
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .opacity(0.5)
                            }
                        } else {
                            CurrencyIcon(
                                currencyImage: currency.image,
                                currencyName: currency.name
                            )
                            .onTapGesture {
                                self.currency = currency
                            }
                        }
                    }
                }
                
                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                
                // Currency Icons
                
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
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(currency: .silverPiece)
}
