//
//  WeatherData+Fcst.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import Foundation

struct FcstItem {
    var type: WeatherOperation // UltraSrt or Vilage
    var baseDateTime: Date?
    var data: [Date: [String: Float]] // [fcstDateTime: [category: fcstValue]]
}

extension FcstItem {
    init(operationType: WeatherOperation, from service: FcstItemService) {
        type = operationType
        
        let items = service.itemList
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmm"
        dateFormatter.locale = Locale(identifier: "kr_KR")
        
        let dateTimeString = items[0].baseDate + items[0].baseTime
        
        baseDateTime = dateFormatter.date(from: dateTimeString)
        
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


