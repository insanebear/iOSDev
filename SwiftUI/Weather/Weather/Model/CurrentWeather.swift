//
//  CurrentWeather.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/25.
//

import Foundation

class CurrentWeather {
    // ultraSrtNcst
    var temperature: Float = -1  // T1H
    var rainFall1hr: Float = -1  // RN1
    var windDegree: Float = -1   // VEC
    var windSpeed: Float = -1    // WSD
    var windElemEW: Float = -1   // UUU
    var windElemSN: Float = -1   // VVV
    var humidity: Float = -1     // REH
    var rainFallType: Float = -1 // PTY
    
    // ultraSrtFcst (based on before 1 hour fcst)
    var sky: Float = -1          // SKY

    func updateDataNcst(with ncstWeatherItem: NcstWeatherItem) {
        for (category, obsrValue) in ncstWeatherItem.ncstData {
            
            switch category {
            case "T1H": temperature = obsrValue
            case "RN1": rainFall1hr = obsrValue
            case "UUU": windElemEW = obsrValue
            case "VVV": windElemSN = obsrValue
            case "REH": humidity = obsrValue
            case "PTY": rainFallType = obsrValue
            case "VEC": windDegree = obsrValue
            case "WSD": windSpeed = obsrValue
            default:
                fatalError("Unknown category")
            }
        }
    }
    
    func updateDataFcst(with fcstWeatherIem: FcstWeatherItem, queryTime: Date) {
        let s = queryTime.stringDateTime().0 + queryTime.stringDateTime().1 + "00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        guard let baseTime = dateFormatter.date(from: s),
              let fcstData = fcstWeatherIem.fcstData[baseTime],
              let skyValue = fcstData["SKY"] else {
            fatalError("Fail to load value for CurrentWeather: SKY")
        }
        
        self.sky = skyValue
    }
    
}
