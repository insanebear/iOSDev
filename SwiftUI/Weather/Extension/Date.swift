//
//  Date.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/25.
//

import Foundation

extension Date {
    func stringDateTime() -> (String, String, String) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: self)
        
        formatter.dateFormat = "HH"
        let hourString = formatter.string(from: self)

        formatter.dateFormat = "mm"
        let minString = formatter.string(from: self)

        return (dateString, hourString, minString)
    }
    
    var hourBefore: Date {
        Calendar.current.date(byAdding: .hour, value: -1, to: self)!
    }
    
    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func dateAt(hours: Int?, minutes: Int?) -> Date {
        let calendar = Calendar.current

        var dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute], from: self)

        if let hours = hours {
            dateComponents.hour = hours
        }
        
        if let minutes = minutes {
            dateComponents.minute = minutes
        }

        return calendar.date(from: dateComponents)!
    }
}
