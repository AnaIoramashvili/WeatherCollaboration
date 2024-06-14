//
//  City.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import Foundation

struct City: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

struct CityAPIResponse: Codable, Identifiable {
    var id: UUID { UUID() }
    var name: String
    var latitude: Double
    var longitude: Double
    var country: String
    var population: Int
    var is_capital: Bool
}

