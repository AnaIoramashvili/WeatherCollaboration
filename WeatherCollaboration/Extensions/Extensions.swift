//
//  Extensions.swift
//  WeatherCollaboration
//
//  Created by Ana on 6/14/24.
//

import Foundation

extension Int {
    func formatHour() -> String {
        return String(format: "%02d", self)
    }
}

extension Int {
    func dayOfWeek() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

extension Int {
    func formatUnixTimestamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

