//
//  AddLocationView.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct AddLocationView: View {
    @EnvironmentObject var cityStore: CityStore
    @Binding var isPresented: Bool
    @State private var cityName = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city name", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Add City") {
                    if !cityName.isEmpty {
                        cityStore.addCity(City(name: cityName))
                        isPresented = false
                    }
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())
            }
            .navigationBarTitle("Add New Location")
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            })
        }
    }
}


