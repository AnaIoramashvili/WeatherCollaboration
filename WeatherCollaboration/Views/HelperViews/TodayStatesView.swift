//
//  TodayStatesView.swift
//  fweathernew
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct TodayStatesView: View {
    
    var chanceOfRain: Int
    var humidityPercentage: Int
    var windSpeed: Int
    
    var body: some View {
        HStack{
            Group {
                HStack {
                    Image(.drizzlePercentageIcon)
                        .renderingMode(.template)
                    
                    Text("\(chanceOfRain) %")
                }
                Spacer()
                HStack {
                    Image(.humidityIcon)
                        .renderingMode(.template)
                    
                    Text("\(humidityPercentage) %")
                }
                Spacer()
                HStack {
                    Image(.windIcon)
                        .renderingMode(.template)
                    
                    Text("\(windSpeed) km/h")
                }
            }
            .foregroundColor(.white)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding()
    }
}

