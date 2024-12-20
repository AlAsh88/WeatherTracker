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
        //        viewModel.loadSavedCityWeather()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background for the weather content
            Color.white.edgesIgnoringSafeArea(.all)
            
            // Weather Details
            VStack() {
                Spacer().frame(width: 204, height: 261)
                
                if viewModel.isLoading {
                    // Show loading spinner
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.top, 50)
                    //                Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    //                Spacer()
                } else {
                    weatherDetailsView
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            // Search Bar
            SearchBar(onSearch: { city in
                viewModel.fetchWeather(for: city)
            })
            .frame(width: 327, height: 46)
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .cornerRadius(15)
            .padding(.horizontal, 24)
            .padding(.top, 44)
        }
    }
    
    
    private var weatherDetailsView: some View {
        VStack(spacing: 16) {
            // Weather Details with Icon first, followed by City Name
            HStack(spacing: 12) {
                if let iconURL = viewModel.iconURL {
                    AsyncImage(url: iconURL) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 123, height: 113) // Set width and height for icon
                        } else if phase.error != nil {
                            Text("❌")
                                .font(.system(size: 40))
                        } else {
                            ProgressView()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                
                Text(viewModel.cityName)
                    .font(.custom("Poppins-SemiBold", size: 36))
                    .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
                    .multilineTextAlignment(.center)
            }
            
            // Temperature
            Text(viewModel.temperature)
                .font(.custom("Poppins-Bold", size: 48))
                .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
            
            // Container Box for Humidity, UV Index, and Feels Like
            HStack {
                VStack {
                    Text(viewModel.humidity)
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .frame(width: 60, height: 43)
                Spacer()
                VStack {
                    Text(viewModel.uvIndex)
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .frame(width: 40, height: 43)
                Spacer()
                VStack {
                    Text(viewModel.feelsLike)
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .frame(width: 60, height: 37)
            }
            .padding()
            .frame(width: 274, height: 75)
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .padding(.top, 16)
        }
    }

}
