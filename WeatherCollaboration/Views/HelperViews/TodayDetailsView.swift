//
//  TodayDetailsView.swift
//  fweathernew
//
//  Created by Ana on 6/14/24.
//

import SwiftUI

struct TodayDetailsView: View {
    var todayTemperature: Int
    var todayMaxTemperature: Int
    var todayMinTemperature: Int
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                
                Group {
                    Text("\(todayTemperature)°")
                        .font(.system(size: 64, weight: .bold))
                    Text("Precipitations")
                        .font(.title2)
                    Text("Max: \(todayMaxTemperature)° Min: \(todayMinTemperature)°")
                        .font(.title3)
                }
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                .foregroundColor(.white)
            }
            .padding(.bottom, 5)
            .padding(.top, 5)
            Spacer()
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding()
        .foregroundStyle(.secondary)
        
    }
}



