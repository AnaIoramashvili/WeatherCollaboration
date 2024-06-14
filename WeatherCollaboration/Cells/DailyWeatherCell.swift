//
//  DailyWeatherCell.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct DailyWeatherCell: View {
    let dailyWeather: DailyWeather
    
    var body: some View {
        
        VStack {
            HStack {
                Text(dailyWeather.dt.dayOfWeek())
                    .frame(width: 100, alignment: .leading)
                    .foregroundColor(.white)
                    .bold()
                
                if let icon = dailyWeather.weather.first?.icon {
                    let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                    AsyncImage(url: iconURL) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 50, height: 50)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(Int(dailyWeather.temp.min))°C")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .trailing) {
                    Text("\(Int(dailyWeather.temp.max))°C")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .padding(.vertical, 5)
        }
        
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding(.horizontal)
        
    }
}


