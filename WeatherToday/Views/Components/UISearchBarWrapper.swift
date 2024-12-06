//
//  UISearchBarWrapper.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import SwiftUI
import UIKit

struct UISearchBarWrapper: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var onSearchButtonClicked: (() -> Void)?
    var onTextChanged: ((String) -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onSearchButtonClicked: onSearchButtonClicked, onTextChanged: onTextChanged)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var onSearchButtonClicked: (() -> Void)?
        var onTextChanged: ((String) -> Void)?
        
        init(text: Binding<String>, onSearchButtonClicked: (() -> Void)?, onTextChanged: ((String) -> Void)?) {
            _text = text
            self.onSearchButtonClicked = onSearchButtonClicked
            self.onTextChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            onTextChanged?(searchText)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            onSearchButtonClicked?()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            text = ""
            searchBar.resignFirstResponder()
        }
    }
}
