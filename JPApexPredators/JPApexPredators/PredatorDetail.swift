//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Alvin on 1/19/25.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator
    
    var body: some View {
        // 'Smart' adjuster for multiple device screen sizes
        // geo, GeometryProxy for screen coordination and resolution
        GeometryReader { geo in
            // VStack starts at the center
            // ScrollView starts at the top
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    
                    // Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        // geo.size.width = width of screen
                        .frame(
                            width: geo.size.width / 1.5,
                            height: geo.size.height / 3.7
                        )
                        // Scale effect doe not afftect the border,
                        // 'breaks out of it'
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                        //.border(.blue, width: 7)
                }
                
                // Dino Name
                
                // Current Location
                
                // Appears in
                
                // Movie moments
                
                // Link to webpage
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PredatorDetail(predator:
                    Predators().apexPredators[2])
//        .preferredColorScheme(.dark)
}
