//
//  CurrentWeather.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/25.
//

import Foundation

class CurrentWeather: ObservableObject {
    // ultraSrtNcst
    @Published var temperature: String = ""  // T1H
    @Published var rainFall1hr: String = ""  // RN1
    @Published var windDegree: String = ""   // VEC
    @Published var windSpeed: String = ""    // WSD
    @Published var windElemEW: String = ""   // UUU
    @Published var windElemSN: String = ""   // VVV
    @Published var humidity: String = ""     // REH
    @Published var rainFallType: String = "" // PTY
    
    // ultraSrtFcst (based on before 1 hour fcst)
    @Published var sky: String = ""          // SKY

    func updateDataNcst(with ncstWeatherItem: NcstWeatherItem) {
        for (category, obsrValue) in ncstWeatherItem.ncstData {
            
            switch category {
            case "T1H":
                if let floatVal = Float(obsrValue) {
                    temperature = "\(round(floatVal * 10) / 10.0)"
                } else {
                    temperature = "Error"
                }

            case "RN1":
                if let floatVal = Float(obsrValue) {
                    switch floatVal {
                    case 0: rainFall1hr = "강수없음"
                    case 0.1..<1.0: rainFall1hr = "1.0mm 미만"
                    case 1.0..<30.0: rainFall1hr = "\(round(floatVal * 10) / 10.0)mm"
                    case 30.0..<50.0: rainFall1hr = "30.0~50.0mm"
                    case 50...: rainFall1hr = "50.0mm 이상"
                    default: rainFall1hr = "Error"
                    }
                } else {
                    rainFall1hr = "강수없음"
                }

            case "UUU": windElemEW = obsrValue
            case "VVV": windElemSN = obsrValue
            case "REH": humidity = obsrValue
            case "PTY":
                switch obsrValue {
                case "0": rainFallType = "없음"
                case "1": rainFallType = "비"
                case "2": rainFallType = "비/눈"
                case "3": rainFallType = "눈"
                case "5": rainFallType = "빗방울"
                case "6": rainFallType = "빗방울눈날림"
                case "7": rainFallType = "눈날림"
                default: rainFallType = "Unknown value: PTY"
                }
            case "VEC": windDegree = obsrValue
            case "WSD": windSpeed = obsrValue
            default:
                fatalError("Unknown category")
            }
        }
    }
    
    func updateDataFcst(with fcstWeatherItem: FcstWeatherItem, queryTime: Date) {
        let fcstTime = queryTime.dateAt(hours: nil, minutes: 00)
        
        guard let fcstData = fcstWeatherItem.fcstData[fcstTime],
              let skyValue = fcstData["SKY"] else {
            fatalError("Fail to load value for CurrentWeather: SKY")
        }
        
        switch skyValue {
        case "1": self.sky = "맑음"
        case "3": self.sky = "구름많음"
        case "4": self.sky = "흐림"
        
        default: self.sky = "Unknown value: SKY"
        }
        
    }
    
}
