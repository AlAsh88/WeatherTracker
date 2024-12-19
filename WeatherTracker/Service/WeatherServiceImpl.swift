//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import Combine
import Foundation

protocol WeatherService {
    func fetchWeather(forCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingFailed:
            return "Failed to decode weather data."
        }
    }
}

class WeatherServiceImpl: WeatherService {
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    private let apiKey = "dcfc7e47d59e41ea949160412241712&q"
    
    func fetchWeather(forCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let weather = try self.decodeWeather(from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }
    
    private func decodeWeather(from data: Data) throws -> WeatherModel {
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherModel.self, from: data)
    }
}
