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
    
    @Published var cityName: String = ""
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
        
        Task.detached { [weak self] in
            guard let self = self else { return }
            
            do {
                let weather = try await self.weatherService.fetchWeather(forCity: city)
                
                await MainActor.run {
                    self.updateWeatherUI(with: weather)
                    self.isLoading = false
                }
            } catch let error as NetworkError {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Unexpected error: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadSavedCityWeather() {
        guard let savedCity = UserDefaults.standard.string(forKey: "SavedCity") else {
            errorMessage = "Please Search For A City."
            return
        }
        fetchWeather(for: savedCity)
    }
    
    private func updateWeatherUI(with weather: WeatherModel) {
        cityName = weather.cityName
        temperature = String(format: "%.1f°F", weather.temperature)
        feelsLike = "Feels Like \(String(format: "%.1f°F", weather.feelsLike))"
        condition = weather.condition
        humidity = "Humidity \(weather.humidity)%"
        uvIndex = "UV Index \(weather.uvIndex)"
        iconURL = weather.iconURL
    }
    
}
