//
//  SearchPageView.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct SearchPageView: View {
    @EnvironmentObject var cityStore: CityStore
    @Binding var isPresented: Bool
    @State private var searchText = ""
    @State private var searchResults: [CityAPIResponse] = []
    @State private var showErrorAlert = false
    @State private var pastSearches: [String] = []
    @State private var isCancelButtonVisible = false
    @State private var debounceTimer: Timer? = nil
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .trailing) {
                    TextField("Search for a city", text: $searchText)
                        .padding(.leading, 24)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 3)
                        .padding(.horizontal)
                        .onChange(of: searchText) { newValue in
                            debounceSearch()
                        }
                    if isCancelButtonVisible {
                        Button(action: {
                            clearSearch()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 30)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                    .frame(height: 450)

                    VStack(spacing: 10) {
                        ForEach(searchText.isEmpty ? pastSearches : searchResults.map { $0.name }, id: \.self) { city in
                            Button(action: {
                                handleCitySelection(city)
                            }) {
                                Text(city)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 50)
                }
            .navigationTitle("Locations")
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text("Failed to fetch cities"), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                loadPastSearches()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            isCancelButtonVisible = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            isCancelButtonVisible = false
        }
    }
    func debounceSearch() {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            searchCities(query: searchText)
        }
    }

    func searchCities(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "https://api.api-ninjas.com/v1/city?name=\(encodedQuery)") else { return }

        var request = URLRequest(url: url)
        request.setValue("UtoHAKzs3pRHde+sayKL1g==pa66gOkDMoriJZuy", forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([CityAPIResponse].self, from: data) {
                    DispatchQueue.main.async {
                        self.searchResults = decodedResponse
                            .filter { $0.name.lowercased().hasPrefix(query.lowercased()) }
                            .sorted { $0.name.lowercased() < $1.name.lowercased() }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.searchResults = []
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showErrorAlert = true
                }
            }
        }.resume()
    }

    func initializePastSearches() {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if !isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            savePastSearch("Tbilisi")
        }
    }

    func loadPastSearches() {
        if let searches = UserDefaults.standard.stringArray(forKey: "pastSearches") {
            pastSearches = searches
        }
    }

    func savePastSearches() {
        UserDefaults.standard.set(pastSearches, forKey: "pastSearches")
    }

    func savePastSearch(_ city: String) {
        if !pastSearches.contains(city) {
            pastSearches.append(city)
            savePastSearches()
        }
    }

    func addCityToStore(city: CityAPIResponse) {
        let newCity = City(name: city.name)
        if !cityStore.cities.contains(where: { $0.name == newCity.name }) {
            cityStore.addCity(newCity)
            savePastSearch(city.name)
            searchText = ""
            searchResults = []
        }
    }

    func addCityToStore(cityName: String) {
        let newCity = City(name: cityName)
        if !cityStore.cities.contains(where: { $0.name == newCity.name }) {
            cityStore.addCity(newCity)
            savePastSearch(cityName)
            searchText = ""
            searchResults = []
        }
    }

    func clearSearch() {
        searchText = ""
        searchResults = []
        loadPastSearches()
    }
    
    func handleCitySelection(_ city: String) {
        searchText = city
        searchResults = []
        viewModel.fetchCityDetails(for: city)
        addCityToStore(cityName: city)
        isPresented = false
    }
}

