//
//  SearchBarView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/19/24.
//

// SearchBarView.swift
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Please Search For A City", text: $searchText)
                .padding(.horizontal, 16)
                .frame(height: 46)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                )
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                    }
                )
        }
        .padding(.horizontal, 24)
        .padding(.top, 44)
    }
}

