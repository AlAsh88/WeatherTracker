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
    
    func testWeatherModelDecoding() {
        let jsonData: Data = """
            {
                "location": {
                    "name": "Ramsey",
                    "region": "Minnesota",
                    "country": "United States of America",
                    "lat": 45.2461,
                    "lon": -93.4519,
                    "tz_id": "America/Chicago",
                    "localtime_epoch": 1734484565,
                    "localtime": "2024-12-17 19:16"
                },
                "current": {
                    "last_updated_epoch": 1734484500,
                    "last_updated": "2024-12-17 19:15",
                    "temp_c": -1.9,
                    "temp_f": 28.6,
                    "is_day": 0,
                    "condition": {
                        "text": "Overcast",
                        "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png",
                        "code": 1009
                    },
                    "wind_mph": 6.7,
                    "wind_kph": 10.8,
                    "wind_degree": 312,
                    "wind_dir": "NW",
                    "pressure_mb": 1025.0,
                    "pressure_in": 30.27,
                    "precip_mm": 0.0,
                    "precip_in": 0.0,
                    "humidity": 80,
                    "cloud": 100,
                    "feelslike_c": -5.8,
                    "feelslike_f": 21.6,
                    "windchill_c": -5.8,
                    "windchill_f": 21.5,
                    "heatindex_c": -2.3,
                    "heatindex_f": 27.9,
                    "dewpoint_c": -7.2,
                    "dewpoint_f": 19.1,
                    "vis_km": 16.0,
                    "vis_miles": 9.0,
                    "uv": 0.0,
                    "gust_mph": 9.2,
                    "gust_kph": 14.9
                }
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherModel.self, from: jsonData)
            XCTAssertEqual(weather.cityName, "Ramsey")
            XCTAssertEqual(weather.temperature, 28.6)
            XCTAssertEqual(weather.feelsLike, 21.6)
            XCTAssertEqual(weather.humidity, 80)
            XCTAssertEqual(weather.uvIndex, 0.0)
            XCTAssertEqual(weather.condition, "Overcast")
            XCTAssertEqual(weather.iconURL.absoluteString, "https://cdn.weatherapi.com/weather/64x64/night/122.png")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
}
