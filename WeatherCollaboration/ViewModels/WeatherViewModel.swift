//
//  WeatherViewModel.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import Foundation
import Combine
import myNetworkPackage
 
 
class WeatherViewModel: ObservableObject {
    @Published var selectedCity: City?
    @Published var selectedCityDetails: CityAPIResponse?
    @Published var weatherInfo: WeatherResponse?
    @Published var didFetchFirst = false
    @Published var selectedCountry: String?
 
    private let apiKey = "UtoHAKzs3pRHde+sayKL1g==pa66gOkDMoriJZuy"
    private let networkService = NetworkService()
 
    func fetchCityDetails(for cityName: String) {
        let urlString = "https://api.api-ninjas.com/v1/city?name=\(cityName)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Failed to fetch city details: \(error.localizedDescription)")
                }
                return
            }
 
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([CityAPIResponse].self, from: data)
                    if let cityDetails = decodedResponse.first {
                        DispatchQueue.main.async {
                            self.selectedCity = City(name: cityDetails.name)
                            self.fetchWeatherInfo(latitude: cityDetails.latitude, longitude: cityDetails.longitude)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.selectedCity = nil
                            self.weatherInfo = nil
                            print("City details response is empty.")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.selectedCity = nil
                        self.weatherInfo = nil
                        print("Failed to decode city details: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
 
    func fetchWeatherInfo(latitude: Double, longitude: Double) {
        let urlString = "https://openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02"
 
        networkService.getData(urlString: urlString) { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let decodedResponse):
                DispatchQueue.main.async {
                    self.weatherInfo = decodedResponse
                    print("Weather data fetched successfully: \(decodedResponse)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.weatherInfo = nil
                    print("Failed to fetch weather data: \(error.localizedDescription)")
                }
            }
        }
    }
    func getWeatherCondition() -> String {
        return weatherInfo?.daily.first?.weather.first?.description ?? "Clear"
    }
}

