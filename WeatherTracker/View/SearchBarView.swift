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
                .padding(.leading, 44) // Padding inside the text field
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
                    .foregroundColor(.gray)
                    .padding(50)
            }
        }
        .frame(height: 46)
        .padding(.leading, 24)
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .cornerRadius(15)
    }

}
