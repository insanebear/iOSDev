//
//  Emoji.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import Foundation

struct Emoji: Equatable, Identifiable {
    var id: String = UUID().uuidString
    var emoji: String
    var description: String
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
        Emoji(emoji: "🤔", description: "Hmm"),
        Emoji(emoji: "🎉", description: "Tada"),
        Emoji(emoji: "🙇‍♂️", description: "Bow"),
        Emoji(emoji: "🐈", description: "Cat"),
    ]
}
