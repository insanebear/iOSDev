//
//  WeatherData+Service.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import Foundation

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
