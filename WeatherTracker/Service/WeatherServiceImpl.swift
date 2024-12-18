//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import Foundation

protocol WeatherService {
    func fetchWeather(forCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
}

class WeatherServiceImpl: WeatherService {
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    private let apiKey = "dcfc7e47d59e41ea949160412241712&q"
    
    func fetchWeather(forCity city: String, completion: @escaping (Result<WeatherModel, any Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: city)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        task.resume()
    }
    
    
    
}
