//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Alvin on 1/19/25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    @Namespace var namespace
    
    // To change the navigation back button text color
    // Assets -> AccentColor -> Appearances, (Any, Dark)
    // Fill color, ^ Note: Any pertains iOS 13 or before since Dark mode wasn't introduced
    // Default color is blue
    
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
                        .overlay {
                            // Applies gradient to blend with background
                            // Stops are 'checkpoints' of the color change
                            // Location is the 'percentage', ex. 0.33 is 33% point
                            LinearGradient(stops:
                                            [
                                                Gradient.Stop(color: .clear,
                                                              location: 0.8),
                                                Gradient.Stop(color: .black,
                                                              location: 1)
                                            ],
                                           startPoint: .top,
                                           endPoint: .bottom
                            )
                        }
                    
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
                
                VStack(alignment: .leading) {
                    // Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current Location
                    NavigationLink {
                        PredatorMap(position: .camera(
                            MapCamera(
                                centerCoordinate: predator.location,
                                distance: 1000,
                                // Angle facing
                                heading: 250,
                                pitch: 80
                                )
                            )
                        )
                        // Useful for which view to start and go to
                        // NavigationLink is the beginning state of transition
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                        
                    } label: {
                        Map(position: $position) {
                            Annotation(
                                predator.name,
                                coordinate: predator.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                                .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    // NavigationLink is the beginning state of transition
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    // Appears in
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    // Provides Identifiable id for each String
                    ForEach(predator.movies, id: \.self) { movie in
                        // Command + Ctrl + Space = open emoji keyboard
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    // ! is similar to Kotlin, enforces the nil safety to be valid
                    Link(predator.link,
                         destination: URL(string: predator.link)!
                    )
                    .font(.caption)
                    .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    
    // The other one is provided in ContentView
    NavigationStack {
        PredatorDetail(predator: predator,
                       position: .camera(
                        MapCamera(
                            // distance is how high up from the ground
                            centerCoordinate: predator.location,
                            distance: 30000
                        )))
        .preferredColorScheme(.dark)
    }
}
