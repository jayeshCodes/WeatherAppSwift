//
//  SearchBar.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

// Compatibility modifier to handle different iOS versions
struct CompatibleSearchBarModifier: ViewModifier {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            Group {
                if #available(iOS 15.0, *) {
                    content.searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter City Name")
                        .onSubmit(of: .search) {
                            isSearching = false
                        }
                }
            }
        } else {
            // For iOS 14 and below
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Enter City Name", text: $text)
                            .foregroundColor(.black)
                            .onTapGesture {
                                isSearching = true
                            }
                        
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    if isSearching {
                        Button("Cancel") {
                            text = ""
                            isSearching = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                         to: nil, from: nil, for: nil)
                        }
                        .foregroundColor(.black)
                        .padding(.leading, 8)
                    }
                }
                .padding(.horizontal)
                .animation(.default, value: isSearching)
                
                content
            }
        }
    }
}

// Search Bar View that uses the compatibility modifier
struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        EmptyView()
            .modifier(CompatibleSearchBarModifier(text: $searchText, isSearching: $isSearching))
    }
}

// Extension to make it easier to use in views
extension View {
    func compatibleSearchBar(text: Binding<String>, isSearching: Binding<Bool>) -> some View {
        self.modifier(CompatibleSearchBarModifier(text: text, isSearching: isSearching))
    }
}
