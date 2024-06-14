//
//  CityStore.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import Foundation

class CityStore: ObservableObject {
    @Published var cities: [City] = [City(name: "Tbilisi")]

    func addCity(_ city: City) {
        if !cities.contains(where: { $0.name == city.name }) {
            cities.append(city)
            saveCities()
        }
    }

    func saveCities() {
        if let encodedData = try? JSONEncoder().encode(cities) {
            UserDefaults.standard.set(encodedData, forKey: "savedCities")
        }
    }

    func loadCities() {
        if let savedData = UserDefaults.standard.data(forKey: "savedCities"),
           let decodedCities = try? JSONDecoder().decode([City].self, from: savedData) {
            cities = decodedCities
        }
    }
}

