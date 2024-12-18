//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/18/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    private let weatherService: WeatherService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var cityName: String = "Search for a city"
    @Published var temperature: String = "--°F"
    @Published var feelsLike: String = ""
    @Published var condition: String = ""
    @Published var humidity: String = ""
    @Published var uvIndex: String = ""
    @Published var iconURL: URL?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(weatherService: WeatherService = WeatherServiceImpl()) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(forCity: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.updateWeatherUI(with: weather)
                case .failure(let error):
                    self?.errorMessage = "Failed to load weather data: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func loadSavedCItyWeather() {
        guard let savedCity = UserDefaults.standard.string(forKey: "SavedCity") else {
            errorMessage = "No saved city. Please search for a city."
            return
        }
        fetchWeather(for: savedCity)
    }
    
    private func updateWeatherUI(with weather: WeatherModel) {
        cityName = weather.cityName
        temperature = String(format: "%.1f°F", weather.temperature)
        feelsLike = "Feels Like: \(String(format: "%.1f°F", weather.feelsLike))"
        condition = weather.condition
        humidity = "Humidity: \(weather.humidity)%"
        uvIndex = "UV Index: \(weather.uvIndex)"
        iconURL = weather.iconURL
    }
    
}
