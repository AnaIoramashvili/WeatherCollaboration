//
//  SearchViewModel.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

//import Foundation
//import SwiftUI
//
//class SearchViewModel: ObservableObject {
//    @Published var searchResults: [CityAPIResponse] = []
//    @Published var showErrorAlert = false
//    @Published var pastSearches: [String] = []
//
//    private var debounceTimer: Timer? = nil
//
//    func debounceSearch(query: String) {
//        debounceTimer?.invalidate()
//        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//            self.searchCities(query: query)
//        }
//    }
//
//    func searchCities(query: String) {
//        guard !query.isEmpty else {
//            searchResults = []
//            return
//        }
//
//        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
//        guard let url = URL(string: "https://api.api-ninjas.com/v1/city?name=\(encodedQuery)") else { return }
//
//        var request = URLRequest(url: url)
//        request.setValue("YourApiKey", forHTTPHeaderField: "X-Api-Key")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data, let decodedResponse = try? JSONDecoder().decode([CityAPIResponse].self, from: data) {
//                DispatchQueue.main.async {
//                    self.searchResults = decodedResponse
//                        .filter { $0.name.lowercased().hasPrefix(query.lowercased()) }
//                        .sorted { $0.name.lowercased() < $1.name.lowercased() }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.showErrorAlert = true
//                }
//            }
//        }.resume()
//    }
//
//    func loadPastSearches() {
//        if let searches = UserDefaults.standard.stringArray(forKey: "pastSearches") {
//            pastSearches = searches
//        }
//    }
//
//    func savePastSearch(_ city: String) {
//        if !pastSearches.contains(city) {
//            pastSearches.append(city)
//            UserDefaults.standard.set(pastSearches, forKey: "pastSearches")
//        }
//    }
//
//    func clearSearch() {
//        searchResults = []
//        loadPastSearches()
//    }
//
//    func addCityToStore(city: CityAPIResponse, cityStore: CityStore) {
//        let newCity = City(name: city.name)
//        if !cityStore.cities.contains(where: { $0.name == newCity.name }) {
//            cityStore.addCity(newCity)
//            savePastSearch(city.name)
//        }
//    }
//}
