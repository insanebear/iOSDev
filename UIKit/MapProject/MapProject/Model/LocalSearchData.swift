//
//  LocalSearchData.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import Foundation

/// Kakao Loal API: https://developers.kakao.com/docs/latest/ko/local/dev-guide

class LocalSearchData: Decodable {
    let documents: [LocalData]
}

final class LocalData: Decodable, Identifiable {
    var id: String
    var name: String
    var roadAddress: String
    var latitude: Double
    var longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "place_name"
        case roadAddress = "road_address_name"
        case latitude = "y"
        case longitude = "x"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: CodingKeys.id)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        roadAddress = try container.decode(String.self, forKey: CodingKeys.roadAddress)
        
        // convert string coordinates to double values
        let str_lat = try container.decode(String.self, forKey: CodingKeys.latitude)
        guard let latitude = Double(str_lat) else {
            let context = DecodingError.Context(codingPath: container.codingPath + [CodingKeys.latitude], debugDescription: "Could not parse json key \"latitude (y)\" to a Double object")
                        throw DecodingError.dataCorrupted(context)
        }
        
        let str_lng = try container.decode(String.self, forKey: CodingKeys.longitude)
        guard let longitude = Double(str_lng) else {
            let context = DecodingError.Context(codingPath: container.codingPath + [CodingKeys.longitude], debugDescription: "Could not parse json key \"longitude (x)\" to a Double object")
                        throw DecodingError.dataCorrupted(context)
        }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
