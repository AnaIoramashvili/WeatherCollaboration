//
//  ContentView.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cityStore: CityStore
    @StateObject private var weatherVM = WeatherViewModel()
    @State private var isSearching = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let weather = weatherVM.weatherInfo {
                        WeatherDetailView(weather: weather)
                    } else {
                        Text("Select a city to see weather details")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SearchPageView(isPresented: $isSearching, viewModel: weatherVM),
                        isActive: $isSearching
                    ) {
                    }
                }
            }
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(cityStore.cities, id: \.self) { city in
                            Button(action: {
                                weatherVM.selectedCity = city
                                weatherVM.fetchCityDetails(for: city.name)
                            }) {
                                Text(city.name)
                            }
                        }
                        Button("Add New Location") {
                            isSearching = true
                        }
                    } label: {
                        Text(weatherVM.selectedCity?.name ?? "Weather App")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            }
            .onAppear {
                
                cityStore.loadCities()
                if let firstCity = cityStore.cities.first  {
                    if !weatherVM.didFetchFirst {
                        weatherVM.selectedCity = firstCity
                        weatherVM.fetchCityDetails(for: firstCity.name)
                        print(firstCity.name)
                        weatherVM.didFetchFirst = true
                    }
                }
            }
        }
    }
}




#Preview {
    ContentView()
}
