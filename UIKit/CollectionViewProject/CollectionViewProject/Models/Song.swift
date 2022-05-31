//
//  Song.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/31.
//

import Foundation

struct Song {
    var title: String
    var artist: String
}

#if DEBUG
extension Song {
    static let songList: [Song] = [
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "CCCCC", artist: "DDDDDD"),
        Song(title: "EEEEE", artist: "EEEEEE"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
        Song(title: "AAAAAA", artist: "BBBBBB"),
    ]
}
#endif
