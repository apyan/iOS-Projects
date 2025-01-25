//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Alvin on 1/24/25.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased()
                    .replacingOccurrences(of: " ", with: ""))
                .resizable()
                // GeometryReader goes by top left, rather than center
                // Note: this framing of the child 'rewrites' the size of the ZStack
                .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    // 'Tricks' to anchor the button by not including it
                    // takes up space (Spacer()) in the parent view
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                            // scale text down to 50% in order to fit
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    // Where the image modifiers take place
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    // Fetching or loading
                                    ProgressView()
                                }
                                // Allows name to be seen
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        Spacer()
                    }
                    
                    Button {
                        // Unit of asynchronous work to run in SwiftUI
                        Task {
                            // Task is needed since await can't run on main thread, UI
                            await vm.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                    }
                    
                    Spacer(minLength: 95)
                }
                // Follows the width to the parent ZStack, hence 2.7 width
                .frame(width: geo.size.width, height: geo.size.height)
            }
            // Goes to the center of GeometryReader, needed for centering
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
//    QuoteView(show: "Better Call Saul")
        .preferredColorScheme(.dark)
}
