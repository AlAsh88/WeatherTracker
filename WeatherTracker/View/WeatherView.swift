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
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            // Weather Details
            VStack() {
                Spacer().frame(width: 204, height: 261)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.top, 50)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    weatherDetailsView
                }
                Spacer()
            }
            .padding(.horizontal, 16)
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
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.clear)
                    .frame(width: 204, height: 261)
                
                VStack {
                    // Weather Icon
                    if let iconURL = viewModel.iconURL {
                        AsyncImage(url: iconURL) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 123, height: 113)
                            } else if phase.error != nil {
                                Text("❌")
                                    .font(.system(size: 40))
                            } else {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    
                    // City Name
                    Text(viewModel.cityName)
                        .font(.custom("Poppins-SemiBold", size: 24))
                        .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
                        .multilineTextAlignment(.center)
                    
                    // Temperature
                    Text(viewModel.temperature)
                        .font(.custom("Poppins-Bold", size: 36))
                        .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172))
                    
                }
            }
            .frame(width: 204, height: 261)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .frame(width: 274, height: 75)
                
                HStack(spacing: 24) {
                    VStack {
                        Text(viewModel.humidity)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 60, height: 43)
                    
                    VStack {
                        Text(viewModel.uvIndex)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 40, height: 43)
                    
                    VStack {
                        Text(viewModel.feelsLike)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 60, height: 37)
                }
                .padding()
                .frame(width: 274, height: 75)
            }
        }
    }
    
}
