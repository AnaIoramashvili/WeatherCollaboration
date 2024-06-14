//
//  WeatherResponse.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import Foundation

struct WeatherResponse: Codable {
    let timezone: String
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let weather: [WeatherDetail]
}

struct HourlyWeather: Codable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let weather: [WeatherDetail]
}

struct DailyWeather: Codable {
    let dt: Int
    let temp: Temp
    let weather: [WeatherDetail]
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct WeatherDetail: Codable {
    let description: String
    let icon: String
}

