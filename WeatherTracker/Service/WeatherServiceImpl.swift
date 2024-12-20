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

extension WeatherService {
    func fetchWeather(forCity city: String) async throws -> WeatherModel {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchWeather(forCity: city) { result in
                switch result {
                case .success(let weather):
                    continuation.resume(returning: weather)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct ErrorResponse: Codable {
    let error: APIError
}

struct APIError: Codable {
    let code: Int
    let message: String
}

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingFailed:
            return "Failed to decode weather data."
        case .apiError(let message):
                    return message
        }
    }
}

class WeatherServiceImpl: WeatherService {
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    private let apiKey = "dcfc7e47d59e41ea949160412241712"
    
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
            
            // Log the raw JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            do {
                let weather = try self.decodeWeather(from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }
    
    func decodeWeather(from data: Data) throws -> WeatherModel {
        let decoder = JSONDecoder()
        // Check if the response contains an error
        if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
            throw NetworkError.apiError(errorResponse.error.message)
        }
        
        // Decode the weather model
        return try decoder.decode(WeatherModel.self, from: data)
    }
}
