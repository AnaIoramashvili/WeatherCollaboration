//
//  PrimaryButtonStyle.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


#Preview {
    PrimaryButtonStyle()
}
