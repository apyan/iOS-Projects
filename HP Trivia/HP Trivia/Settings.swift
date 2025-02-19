//
//  Settings.swift
//  HP Trivia
//
//  Created by Alvin on 2/10/25.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Text("Which books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        // 0 to 6, hence 7 times
                        ForEach(0..<7) { i in
                            if (store.books[i] == .active ||
                                (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i + 1)"))) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .task {
                                    store.books[i] = .active
                                }
                                .onTapGesture {
                                    store.books[i] = .inactive
                                }
                            } else if (store.books[i] == .inactive) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.33))
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green.opacity(0.5))
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.books[i] = .active
                                }
                            } else {
                                ZStack {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.75))
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color: .white.opacity(0.75), radius: 3)
                                }
                                .onTapGesture {
                                    // -3 due to the product 'index' vs book index
                                    let product = store.products[i - 3]
                                    
                                    Task {
                                        await store.purchase(product)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Settings()
        .environmentObject(Store())
}
