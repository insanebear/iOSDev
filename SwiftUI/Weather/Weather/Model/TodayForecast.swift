//
//  TodayForecast.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/25.
//

import Foundation

class TodayForecast {
    // vilage (srtFcst)
    var maxTemp: String = ""      // TMX - value of 15:00
    var minTemp: String = ""     // TMN - value of 06:00
//    var probRain: String = ""     // POP - value of
    
    func updateVilageFcstData(with vilageFcstItem: FcstWeatherItem, queryTime: Date) {
        // 0600, 1500
        let minTempTime = queryTime.stringDateTime().0 + "0600"
        let maxTempTime = queryTime.stringDateTime().0 + "1500"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        guard let minTempBaseTime = dateFormatter.date(from: minTempTime),
              let minTempFcstData = vilageFcstItem.fcstData[minTempBaseTime],
              let minTempValue = minTempFcstData["TMN"] else {
            fatalError("Fail to load value for CurrentWeather: TMN")
        }
        
        self.minTemp = minTempValue
        
        guard let maxTempBaseTime = dateFormatter.date(from: maxTempTime),
              let maxTempFcstData = vilageFcstItem.fcstData[maxTempBaseTime],
              let maxTempValue = maxTempFcstData["TMX"] else {
            fatalError("Fail to load value for CurrentWeather: TMX")
        }
        
        self.maxTemp = maxTempValue

    }
}
