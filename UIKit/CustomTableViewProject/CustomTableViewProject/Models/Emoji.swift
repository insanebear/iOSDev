//
//  Emoji.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/22.
//

import Foundation

struct Emoji: Equatable, Identifiable {
    var id: String = UUID().uuidString
    
    var emoji: String
    var description: String
    var isFavorite: Bool
}

extension Array where Element == Emoji {
    func indexOfEmoji(with id: Emoji.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

extension Emoji {
    static var sampleEmojis: [Emoji] = [
        Emoji(emoji: "🤔", description: "Hmm", isFavorite: false),
        Emoji(emoji: "🎉", description: "Tada", isFavorite: true),
        Emoji(emoji: "🙇‍♂️", description: "Bow", isFavorite: false),
        Emoji(emoji: "🐈", description: "Cat", isFavorite: false),
        Emoji(emoji: "😄", description: "Smile", isFavorite: true),
        Emoji(emoji: "😉", description: "Wink", isFavorite: false),
        Emoji(emoji: "👻", description: "Ghost", isFavorite: false),
        Emoji(emoji: "👑", description: "Crown", isFavorite: false),
        Emoji(emoji: "🎩", description: "Hat", isFavorite: false),
        Emoji(emoji: "🧶", description: "Yarn", isFavorite: false),
    ]
}
