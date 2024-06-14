//
//  HourlyWeatherCell.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI
 
struct HourlyWeatherCell: View {
    let hourlyWeather: HourlyWeather
    @State private var isSelected: Bool = false
 
    var body: some View {
        ZStack {
            if isSelected {
                RadialGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.0)]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 70
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(1)
            }
 
            VStack(spacing: 16) {
                
                Text("\(Int(hourlyWeather.temp))°C")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
                
                if let icon = hourlyWeather.weather.first?.icon {
                    let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                    AsyncImage(url: iconURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 45, height: 45)
                    .aspectRatio(contentMode: .fit)
                }
            
                
                Text("\(hourlyWeather.dt.formatUnixTimestamp())")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
            }
            .frame(width: 70, height: 155)
            .background(Color.white.opacity(isSelected ? 0.2 : 0.0))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
            )
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}
