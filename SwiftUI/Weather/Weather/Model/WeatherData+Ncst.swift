//
//  WeatherData+Ncst.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

struct NcstItem {
    var baseDateTime: Date?
    var data: [String: Float]
}

extension NcstItem {
    init(from service: NcstItemService) {
        let items = service.itemList
        
        // to convert time string to Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        let dateTimeString = items[0].baseDate + items[0].baseTime
        
        baseDateTime = dateFormatter.date(from: dateTimeString)
        
        // to store category and obsrValue into dictionary
        var tempData: [String: Float] = [:]
        for item in items {
            tempData[item.category] = Float(item.obsrValue)
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
