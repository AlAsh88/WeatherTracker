//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        // Load the weather for the saved city when the view appears
        viewModel.loadSavedCityWeather()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading {
                // Show loading spinner
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.top, 50)
            } else if let errorMessage = viewModel.errorMessage {
                // Show error message
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
            } else {
                // City Name
                Text(viewModel.cityName)
                    .font(.custom("Poppins-SemiBold", size: 36))
                    .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
                    .multilineTextAlignment(.center)
                
                // Temperature and Weather Condition
                HStack(spacing: 12) {
                    Text(viewModel.temperature)
                        .font(.custom("Poppins-Bold", size: 48))
                        .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
                    
                    VStack {
                        if let iconURL = viewModel.iconURL {
                            // Display weather icon from URL
                            AsyncImage(url: iconURL) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                } else if phase.error != nil {
                                    Text("❌")
                                        .font(.system(size: 40))
                                } else {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                        Text(viewModel.condition)
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.gray)
                    }
                }
                
                // Feels Like Temperature
                Text(viewModel.feelsLike)
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(.gray)
                
                // Humidity
                Text(viewModel.humidity)
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(.gray)
                
                // UV Index
                HStack {
                    Text(viewModel.uvIndex)
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.gray)
                    
                    // Optional: Color coding the UV index for easy understanding
                    Spacer()
                    Text(viewModel.uvIndex)
                        .foregroundColor(uvIndexColor(uvIndex: viewModel.uvIndex))
                }
                
                Spacer()
            }
            // Search Bar
            SearchBar(onSearch: { city in
                viewModel.fetchWeather(for: city)
            })
            .padding(.top, 20)
        }
        .padding(24)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    // Helper method to get color for UV index
    func uvIndexColor(uvIndex: String) -> Color {
        guard let uvValue = Double(uvIndex) else { return .green }
        switch uvValue {
        case 0...3: return .green
        case 4...6: return .yellow
        case 7...10: return .red
        default: return .purple
        }
    }
}
