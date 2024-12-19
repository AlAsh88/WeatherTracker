//
//  WeatherDetailView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/19/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                if let iconURL = viewModel.iconURL {
                    // Weather icon
                    AsyncImage(url: iconURL) { image in
                        image.resizable()
                             .scaledToFit()
                             .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.leading, 20)
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.cityName)
                        .font(.title)
                        .padding(.bottom, 5)
                    
                    Text(viewModel.temperature)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(viewModel.condition)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    
                    Text("Feels Like: \(viewModel.feelsLike)")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    
                    Text("Humidity: \(viewModel.humidity)%")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    
                    Text("UV Index: \(viewModel.uvIndex)")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                }
                .padding(.leading, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            .padding([.leading, .trailing], 20)
        }
        .padding([.top, .bottom], 20)
    }
}
