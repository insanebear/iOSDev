//
//  WeatherData.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

// MARK: 초단기현황 (getUltraSrtNcst)
struct NcstWeatherItem {
    var baseDateTime: Date?
    var ncstData: [String: Float] // [category: obsrValue]]
}

extension NcstWeatherItem {
    init(from service: NcstItemService) {
        let items = service.itemList
        var tempData: [String: Float] = [:]
        
        for item in items {
            if let obsrValue = Float(item.obsrValue) {
                tempData[item.category] = obsrValue
            }
        }
        
        ncstData = tempData
    }
}

// MARK: 초단기예보(getUltraSrtFcst), 단기예보(동네예보, getVilageFcst)
struct FcstWeatherItem {
    var baseDateTime: Date?
    var fcstData: [Date: [String: Float]] // [fcstTime: [category: fcstValue]]
}
extension FcstWeatherItem {
    init(from service: FcstItemService) {
        
        let items = service.itemList
        
        // to convert time string to Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        let baseDateTimeString = items[0].baseDate + items[0].baseTime
        
        baseDateTime = dateFormatter.date(from: baseDateTimeString)
        
        var tempData: [Date: [String: Float]] = [:]
        for item in items {
            let fcstDateTimeString = item.fcstDate + item.fcstTime
            
            if let fcstDateTime = dateFormatter.date(from: fcstDateTimeString),
               let fcstValue = Float(item.fcstValue) {
                
                if tempData[fcstDateTime] == nil {
                    tempData[fcstDateTime] = [item.category: fcstValue]
                } else {
                    tempData[fcstDateTime]![item.category] = fcstValue
                }
            }
        }
        
        fcstData = tempData
    }
}
