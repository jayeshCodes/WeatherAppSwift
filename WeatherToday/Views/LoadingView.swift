//
//  LoadingView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import SwiftSpinner

struct LoadingView: View {
    let title: String
    
    init(_ title: String = "Loading...") {
        self.title = title
    }
    
    var body: some View {
        Color.clear
            .onAppear {
                SwiftSpinner.show(title)
            }
            .onDisappear {
                SwiftSpinner.hide()
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
