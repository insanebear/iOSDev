//
//  WeatherData.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

struct WeatherItem {
    var type: WeatherOperation
    var baseDateTime: Date?
    var data: [Date: [String: Float]] // [dateTime: [category: fcstValue]]
}

extension WeatherItem {
    // Initializer for NcstItemService
    init(operationType: WeatherOperation, from service: NcstItemService) {
        type = operationType
        
        let items = service.itemList

        // to convert time string to Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"

        let dateTimeString = items[0].baseDate + items[0].baseTime

        baseDateTime = dateFormatter.date(from: dateTimeString)
        
        var tempData: [Date: [String: Float]] = [:]
        if let baseDateTime = baseDateTime {
            tempData = [baseDateTime:[:]]
            
            for item in items {
                if let obsrValue = Float(item.obsrValue) {
                    tempData[baseDateTime]![item.category] = obsrValue
                }
            }
        }
        data = tempData
    }
    
    // Initializer for FcstItemService
    init(operationType: WeatherOperation, from service: FcstItemService) {
        type = operationType
        
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
        data = tempData
    }
}
