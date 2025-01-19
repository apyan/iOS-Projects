//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Alvin on 1/19/25.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = APType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        // Navigation Stack is used to stack screens on top of each other
        // Similar to ZStack but with more 'power'
        NavigationStack {
            // Scrolling and Lazy Loading is built into List
            // Unlike ForEach
            List(filteredDinos) { predator in
                // The right 'arrow'
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        // Dinosaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            // Uses subtle animation of expanding or shrinking list
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Add animation to the list, arrangements
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
//                        if (alphabetical) {
//                            Image(systemName: "film")
//                        } else {
//                            Image(systemName: "textformat")
//                        }
                        
                        // Ternary operator
                        Image(systemName: alphabetical
                              ? "film" : "textformat")
                        .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        // Title will be shown depending on device
                        // helps the coder nonetheless
                        // Animate the filtering
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(
                                    type.rawValue.capitalized,
                                    systemImage: type.icon
                                )
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
