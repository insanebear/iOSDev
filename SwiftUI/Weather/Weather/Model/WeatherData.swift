//
//  WeatherData.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

struct NcstItem: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let nx: Int
    let ny: Int
    let obsrValue: String
}

struct UltraSrtNcst: Decodable {
    let ncstItems: [NcstItem]
    
    private enum CodingKeys: String, CodingKey {
        case response
        case body
        case items
        case ncstItems = "item"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        let bodyContainer = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .body)
        let itemsContainer = try bodyContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        
        ncstItems = try itemsContainer.decode([NcstItem].self, forKey: .ncstItems)
    }
}
