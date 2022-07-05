//
//  TodayForecast.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/25.
//

import Foundation

class TodayForecast: ObservableObject {
    // vilage (srtFcst)
    @Published var maxTemp: String = ""      // TMX - value of 15:00
    @Published var minTemp: String = ""     // TMN - value of 06:00
    @Published var probRain: String = ""     // POP - value of now
    
    func updateVilageFcstData(with vilageFcstItem: FcstWeatherItem, queryTime: Date) {
        var tmn: String!
        var tmx: String!
        var pop: String!
        
        let tmnFcstTime = queryTime.dateAt(hours: 6, minutes: 00)
        let tmxFcstTime = queryTime.dateAt(hours: 15, minutes: 00)
        let popFcstTime = queryTime.dateAt(hours: nil, minutes: 00)
        
        if queryTime < queryTime.dateAt(hours: 02, minutes: 10) {
            // baseTime: yesterday 23:00
            tmn = vilageFcstItem.fcstData[tmnFcstTime]!["TMN"]
            tmx = vilageFcstItem.fcstData[tmxFcstTime]!["TMX"]
            pop = vilageFcstItem.fcstData[popFcstTime]!["POP"]
            
            self.minTemp = tmn
            self.maxTemp = tmx
            self.probRain = pop
        } else {
            guard let baseTime = vilageFcstItem.baseDateTime else { return }
            
            guard let baseTimeHours = Int(baseTime.stringDateTime().1),
                  let currentTimeHours = Int(queryTime.stringDateTime().1) else {
                fatalError("Cannot convert Date() to hours and minutes String")
            }
            
            // TMN
            if baseTimeHours == 2 {
                tmn = vilageFcstItem.fcstData[tmnFcstTime]!["TMN"]
                self.minTemp = tmn
            }
            
            // TMX
            if [2, 5, 8, 11].contains(baseTimeHours) {
                tmx = vilageFcstItem.fcstData[tmxFcstTime]!["TMX"]
                self.maxTemp = tmx
            }
            
            // POP
            print("BaseTime:", baseTimeHours,", CurrentTime:", currentTimeHours)
            if ![2, 11].contains(baseTimeHours)
                || ([2, 11].contains(baseTimeHours) && baseTimeHours == currentTimeHours) {
                
            }
            
            if baseTimeHours == 2 && 3...5 ~= currentTimeHours
                || baseTimeHours == 11 && 12...14 ~= currentTimeHours
                || ![2, 11].contains(baseTimeHours) {
                
                pop = vilageFcstItem.fcstData[popFcstTime]!["POP"]
                self.probRain = pop
            }
        }
    }
}
