//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        Group {
            if viewModel.cityName.isEmpty {
                HomeEmptyStateView()
            } else {
                VStack {
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                    
                    Text(viewModel.temperature)
                        .font(.title)
                    
                    // Add more weather details here
                }
            }
        }
    }
}
