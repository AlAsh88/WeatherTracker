//
//  HomeEmptyStateView.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/19/24.
//

import SwiftUI

struct HomeEmptyStateView: View {
    @State private var searchText: String = ""
    
    var body: some View {
            VStack(spacing: 24) {
                // Search Bar
                HStack {
                    TextField("Search Location", text: $searchText)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .cornerRadius(16)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 16)
                            }
                        )
                }
                .frame(width: 327, height: 46)
                .padding(.top, 44) // Adjust padding based on overall layout

                // No City Selected Message
                VStack(spacing: 8) {
                    Text("No City Selected")
                        .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172)) // Set text color as 2C2C2C
                        .font(.custom("Poppins-SemiBold", size: 30)) // Set the font size as specified
                        .lineSpacing(15)
                        .frame(width: 280, height: 60)
                        .background(Color.clear) // Make background transparent
                        .cornerRadius(10) // Optional corner radius for styling
                        .multilineTextAlignment(.center)

                    Text("Please Search For A City")
                        .foregroundColor(Color(red: 0.172, green: 0.172, blue: 0.172)) // Set text color as 2C2C2C
                        .font(.custom("Poppins-SemiBold", size: 15)) // Font size and weight as specified
                        .lineSpacing(7.5) // Set line height as per your request (half of 15px)
                        .frame(width: 280, height: 60)
                        .background(Color.clear) // Make background transparent
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .underline(true, color: .white) // Underline text with white color
                }
                .frame(maxWidth: .infinity, alignment: .center) // Center the text vertically and horizontally

                Spacer() // Push content to the top of the screen
            }
            .padding(.horizontal, 24)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }

}
