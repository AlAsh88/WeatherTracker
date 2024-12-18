//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/17/24.
//

import SwiftUI

struct ContentView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .font(.largeTitle)
            .padding()
    }
    
}

#Preview {
    ContentView(message: "Hello from UIKit!")
}
