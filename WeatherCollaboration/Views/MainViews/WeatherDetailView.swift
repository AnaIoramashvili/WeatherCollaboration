//
//  WeatherDetailView.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            TodayDetailsView(
                todayTemperature: Int(weather.current.temp),
                todayMaxTemperature: Int(weather.daily.first?.temp.max ?? 0),
                todayMinTemperature: Int(weather.daily.first?.temp.min ?? 0)
            )
            
            TodayStatesView(
                chanceOfRain: Int(weather.current.dew_point),
                humidityPercentage: weather.current.humidity,
                windSpeed: Int(weather.current.wind_speed)
            )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(weather.hourly.prefix(24), id: \.dt) { hourlyWeather in
                        HourlyWeatherCell(hourlyWeather: hourlyWeather)
                    }
                }
                .padding()
            }
            Spacer()
                .frame(height: 40)
            
            LazyVStack {
                ForEach(weather.daily.prefix(7), id: \.dt) { dailyWeather in
                    DailyWeatherCell(dailyWeather: dailyWeather)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 20)
        }
        .padding()
    }
}



#Preview {
    WeatherDetailView()
}
