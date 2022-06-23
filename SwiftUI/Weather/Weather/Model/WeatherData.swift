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
    
    init(operationType: WeatherOperation, from service: FcstItemService) {
        type = operationType
        
        let items = service.itemList
        
        // to convert time string to Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        dateFormatter.locale = Locale(identifier: "kr_KR")
        
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

struct NcstItemService: Decodable {
    let itemList: [Item]
    
    struct Item: Decodable {
        let baseDate: String
        let baseTime: String
        let category: String
        let obsrValue: String
    }
    
    // coding key to access nested containers
    private enum CodingKeys: String, CodingKey {
        case response
        case body
        case items
        case item
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        let bodyContainer = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .body)
        let itemsContainer = try bodyContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)

        // decode item using [Item] from itemsContainer
        itemList = try itemsContainer.decode([Item].self, forKey: .item)
    }
}

struct FcstItemService: Decodable {
    let itemList: [Item]
    
    struct Item: Decodable {
        let baseDate: String
        let baseTime: String
        let category: String
        let fcstDate: String
        let fcstTime: String
        let fcstValue: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case response
        case body
        case items
        case item
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        let bodyContainer = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .body)
        let itemsContainer = try bodyContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)

        itemList = try itemsContainer.decode([Item].self, forKey: .item)
    }
}
