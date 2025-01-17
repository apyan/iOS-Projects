//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Alvin on 1/4/25.
//

import SwiftUI

// struct is practically immutable
// let is immutable
struct ContentView: View {
    // @State allows property change in struct, state of the view
    // Need it for an indicator of change of view
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    // @FocusState tracks which part of the app is currently focused
    // A bool by default
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    var body: some View {
        ZStack {
            // Background Image
            Image(.background) // or Image("background")
                .resizable()    // Top and bottom white bar areas are meant for status
                .ignoresSafeArea()  // ^ Fills only the "safe area"
            
            VStack {
                // Prancing Pony Image
                Image(.prancingpony)
                    .resizable()    // Contained within the screen
                    .scaledToFit()  // Maintains width:height ratio
                    .frame(height: 200)
                
                // Currency Exchange Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Converstion Section
                HStack {
                    // Left Conversion Section
                    VStack {
                        // Currency
                        HStack {
                            // Currency Image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        // Text Field
                        // Bindings are two way communication
                        // $ is a binding
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                    }
                    
                    // Equal Sign
                    Image(systemName: "equal")  // Access the SF symbol of Equal
                        .font(.largeTitle)      // systemName refers outside of the app
                        .foregroundStyle(.white)// SF symbols can be treated as both
                        .symbolEffect(.pulse)   // image or text
                    
                    // Right Conversion Section
                    VStack {
                        // Currency
                        HStack {
                            // Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency Image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        // Text Field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                // Covers keyboard type for all TextFields, etc...
                .keyboardType(.decimalPad)
                
                Spacer()
                
                // Info Button
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                        
                        // String interpolation
//                      print("showExchangeInfo value: \(showExchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
                
            }
            // For Left TextField
            .onChange(of: leftAmount) {
                if (leftTyping) {
                    rightAmount = leftCurrency.convert(
                        leftAmount,
                        to: rightCurrency
                    )
                }
            }
            // For Right TextField
            .onChange(of: rightAmount) {
                if (rightTyping) {
                    leftAmount = rightCurrency.convert(
                        rightAmount,
                        to: leftCurrency
                    )
                }
            }
            // Currency change from Selection screen
            .onChange(of: leftCurrency) {
                leftAmount = rightCurrency.convert(
                    rightAmount,
                    to: leftCurrency
                )
            }
            // Currency change from Selection screen
            .onChange(of: rightCurrency) {
                rightAmount = leftCurrency.convert(
                    leftAmount,
                    to: rightCurrency
                )
            }
            .sheet(isPresented: $showExchangeInfo) {
                // sheet is being watched by the showExchangeInfo,
                // a variable sought by overall
                // hence controlled by Button's toggling
                // also, can be placed anywhere on the content view's code
                ExchangeInfo()
            }
            .sheet(isPresented: $showSelectCurrency) {
                SelectCurrency(
                    topCurrency: $leftCurrency,
                    bottomCurrency: $rightCurrency
                )
            }
//            .border(.blue)
        }
    }
}

#Preview {
    ContentView()
}
