//
//  WeatherModel.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import Foundation

public struct WeatherModel: Codable {
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let uvIndex: Double
    let condition: String
    let iconURL: URL
    
    enum RootKeys: String, CodingKey {
        case location
        case current
    }
    
    enum LocationKeys: String, CodingKey {
        case name
    }
    
    enum CurrentKeys: String, CodingKey {
        case tempF = "temp_f"
        case feelsLikeF = "feelslike_f"
        case humidity
        case uv
        case condition
    }
    
    enum ConditionKeys: String, CodingKey {
        case text
        case icon
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let rootContainer = try decoder.container(keyedBy: RootKeys.self)
            
            let locationContainer = try rootContainer.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
            cityName = try locationContainer.decode(String.self, forKey: .name)
            
            let currentContainer = try rootContainer.nestedContainer(keyedBy: CurrentKeys.self, forKey: .current)
            temperature = try currentContainer.decode(Double.self, forKey: .tempF)
            feelsLike = try currentContainer.decode(Double.self, forKey: .feelsLikeF)
            humidity = try currentContainer.decode(Int.self, forKey: .humidity)
            uvIndex = try currentContainer.decode(Double.self, forKey: .uv)
            
            let conditionContainer = try currentContainer.nestedContainer(keyedBy: ConditionKeys.self, forKey: .condition)
            condition = try conditionContainer.decode(String.self, forKey: .text)
            let iconPath = try conditionContainer.decode(String.self, forKey: .icon)
            iconURL = URL(string: "https:" + iconPath)!
        } catch {
            print("Decoding failed: \(error)")
            throw error
        }
    }
    
}
