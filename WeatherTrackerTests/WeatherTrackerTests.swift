//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import XCTest
@testable import WeatherTracker

final class WeatherTrackerTests: XCTestCase {

    func test_fetch_weatherService() {
        let weatherService: WeatherService = WeatherServiceImpl()
        weatherService.fetchWeather(forCity: "New York") { result in
            switch result {
            case .success(let weather):
                print("!!!! Weather Data: !!!!")
                print("City: \(weather.cityName)")
                print("Temperature: \(weather.temperature)°F")
                print("Feels Like: \(weather.feelsLike)°F")
                print("Humidity: \(weather.humidity)%")
                print("UV Index: \(weather.uvIndex)")
                print("Condition: \(weather.condition)")
                print("Icon URL: \(weather.iconURL)")
            case .failure(let error):
                print("Failed to fetch weather: \(error)")
            }
        }
    }

}
