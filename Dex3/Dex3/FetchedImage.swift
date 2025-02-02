//
//  FetchedImage.swift
//  Dex3
//
//  Created by Alvin on 2/1/25.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    
    var body: some View {
        // Made sure url 'exists', proceed forth
        // This acts like a chain of if-else statement
        // Moves to the next 'let' if the previous is true
        if let url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image("bulbasaur")
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}
