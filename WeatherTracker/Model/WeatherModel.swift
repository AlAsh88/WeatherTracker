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
        
        
        case iconURL = "icon"
    }
    
    enum LocationKeys: String, CodingKey {
        case cityName = "name"
    }
    
    enum CurrentKeys: String, CodingKey {
        case temperature = "temp_f"
        case feelsLike = "feelslike_f"
        case humidity
        case uvIndex = "uv"
        case condition
    }
    
    enum ConditionKeys: String, CodingKey {
        case text
        case icon
    }
    
    public init(from decoder: any Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        
        let locationContainer = try decoder.container(keyedBy: LocationKeys.self)
        self.cityName = try locationContainer.decode(String.self, forKey: .cityName)
        
        let currentContainer = try decoder.container(keyedBy: CurrentKeys.self)
        self.temperature = try currentContainer.decode(Double.self, forKey: .temperature)
        self.feelsLike = try currentContainer.decode(Double.self, forKey: .feelsLike)
        self.humidity = try currentContainer.decode(Int.self, forKey: .humidity)
        self.uvIndex = try currentContainer.decode(Double.self, forKey: .uvIndex)
        
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: ConditionKeys.self, forKey: .condition)
        self.condition = try conditionContainer.decode(String.self, forKey: .text)
        
        let iconPath = try conditionContainer.decode(String.self, forKey: .icon)
        guard let url = URL(string: "https:\(iconPath)") else {
            throw DecodingError.dataCorruptedError(forKey: .icon, in: conditionContainer, debugDescription: "Invalid icon URL")
        }
        self.iconURL = try rootContainer.decode(URL.self, forKey: .iconURL)
    }
    
}
