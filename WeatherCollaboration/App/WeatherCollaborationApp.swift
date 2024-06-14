//
//  WeatherCollaborationApp.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

@main
struct WeatherCollaborationApp: App {

    @StateObject private var cityStore = CityStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cityStore)
        }
    }
}
