//
//  SearchBarView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/19/24.
//

// SearchBarView.swift
import SwiftUI

struct SearchBar: View {
    @State private var searchText: String = ""
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search for a city", text: $searchText)
                .padding(12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .onSubmit {
                    onSearch(searchText)
                }
            
            Button(action: {
                onSearch(searchText)
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 16)
        .frame(width: 327, height: 46)  // Width and height from Figma
        .background(Color(red: 242/255, green: 242/255, blue: 242/255))
        .cornerRadius(15)
        .padding( .top, 24)
        .padding(.leading, 24)
    }
}

struct SearchResultCard: View {
    let cityName: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(cityName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}
