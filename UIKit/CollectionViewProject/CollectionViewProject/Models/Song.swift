//
//  Song.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/31.
//

import Foundation

struct SearchResponse: Codable {
  var results: [Song]
}

struct Song: Codable, Identifiable {
    let id: Int
    let trackName: String
    let artistName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
    }
}
