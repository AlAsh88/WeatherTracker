# Weather Tracker

This Weather Tracker fetches and displays weather information for a selected city using the OpenWeatherMap API. It supports persistence of the last searched city, MVVM-C architecture, dependency injection, and error handling. The app demonstrates both UIKit and SwiftUI for UI development.

## Features
- Search for current weather by city.
- Displays temperature, feels like temperature, condition, humidity, UV index, and weather icon.
- Persists the last searched city across app launches.
- Error handling for network and API errors.
- Supports portrait and landscape orientations.
- MVVM-C architecture with dependency injection.
- Accessibility and localization ready.
- Image caching for performance optimization.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- macOS with Xcode 15 or later installed.
- Swift 5.9 or later.
- An API key from [OpenWeatherMap](https://openweathermap.org/api).

## Setup Instructions

### 1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone <repository_url>
cd weather-app
```

### 2. Open the Project in Xcode
Open the `.xcodeproj` file in Xcode:
```bash
open WeatherTracker.xcodeproj
```

### 3. Add API Key
1. Create a new file named `Secrets.plist` in the project root.
2. Add your OpenWeatherMap API key in the following format:
```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>OpenWeatherAPIKey</key>
    <string>Your_API_Key_Here</string>
</dict>
</plist>
```
3. Ensure `Secrets.plist` is added to the project.

### 4. Run the App
Select a simulator or connected device, then build and run the app:
```bash
Command + R
```

### 5. Using the App
1. Enter a city name in the search bar and press "Search."
2. View the weather information for the city.
3. Quit and relaunch the app to see the last searched city persist.

## Additional Notes
- The app is designed to handle errors gracefully and display appropriate messages to the user.
- To test the app's localization and accessibility features, use Xcode's Accessibility Inspector and localization settings.
