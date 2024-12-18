//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import XCTest
@testable import WeatherTracker

final class WeatherServiceTests: XCTestCase {
    var weatherService: WeatherServiceImpl!
    
    override func setUp() {
        super.setUp()
        weatherService = WeatherServiceImpl()
    }
    
    override func tearDown() {
        weatherService = nil
        super.tearDown()
    }

    func test_fetch_weatherService() throws {
        let json = """
        {
            "location": { "name": "Mahwah" },
            "current": {
                "temp_f": 48.9,
                "feelslike_f": 45.1,
                "humidity": 59,
                "uv": 0.0,
                "condition": {
                    "text": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                }
            }
        }
        """.data(using: .utf8)!
        
        let weather = try weatherService.decodeWeather(from: json)
        
        XCTAssertEqual(weather.cityName, "Mahwah")
        XCTAssertEqual(weather.temperature, 48.9)
        XCTAssertEqual(weather.feelsLike, 45.1)
        XCTAssertEqual(weather.humidity, 59)
        XCTAssertEqual(weather.uvIndex, 0.0)
        XCTAssertEqual(weather.condition, "Clear")
        XCTAssertEqual(weather.iconURL.absoluteString, "https://cdn.weatherapi.com/weather/64x64/night/113.png")
    }
    
    func test_decodeWeather_Failure() {
        let invalidJson = """
            {
                "invalid_key": "some_value"
            }
            """.data(using: .utf8)!
        
        XCTAssertThrowsError(try weatherService.decodeWeather(from: invalidJson)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }

}
