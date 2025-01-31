//
//  Stats.swift
//  Dex3
//
//  Created by Alvin on 1/30/25.
//

import SwiftUI
import Charts

struct Stats: View {
    @EnvironmentObject var pokemon: Pokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(
                x: .value("Value", stat.value),
                y: .value("Stat", stat.label)
            )
            .annotation(position: .trailing) {
                Text("\(stat.value)")
                    .padding(.top, -5)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(height: 200)
        .padding([.leading, .bottom, .trailing])
        .foregroundColor(Color(pokemon.types![0].capitalized))
        // Increase the max range of the chart to prevent clipping off
        // Ex. the numbers will get clipped off
        // Chart has a 'smart' choosign of the max value
        .chartXScale(domain: 0...pokemon.highestStat.value + 5)
    }
}

#Preview {
    Stats().environmentObject(SamplePokemon.samplePokemon)
}
