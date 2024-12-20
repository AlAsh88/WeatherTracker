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
            // Search Location TextField
            TextField("Search Location", text: $searchText)
                .font(.custom("Poppins-Regular", size: 15))
                .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                .frame(width: 121, height: 23)
                .padding(.leading, 8) // Padding inside the text field
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(8)
                .onSubmit {
                    onSearch(searchText)
                }
            
            // Magnifying Glass Icon Button
            Button(action: {
                onSearch(searchText)
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
                    .padding(12)
            }
        }
        .padding(.horizontal, 16) // Outer padding for alignment
        .frame(height: 46) // Adjust height to match design
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .cornerRadius(15) // Apply corner radius to the background
    }

}
