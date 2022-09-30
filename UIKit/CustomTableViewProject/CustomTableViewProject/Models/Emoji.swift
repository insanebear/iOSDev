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
    var icon: String
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
        Emoji(emoji: "🤔", description: "Hmm", isFavorite: false, icon: "face.smiling.fill"),
        Emoji(emoji: "🎉", description: "Tada", isFavorite: true, icon: "f.circle.fill"),
        Emoji(emoji: "🙇‍♂️", description: "Bow", isFavorite: false, icon: "face.smiling.fill"),
        Emoji(emoji: "🐈", description: "Cat", isFavorite: false, icon: "a.circle.fill"),
        Emoji(emoji: "😄", description: "Smile", isFavorite: true, icon: "face.smiling.fill"),
        Emoji(emoji: "😉", description: "Wink", isFavorite: false, icon: "face.smiling.fill"),
        Emoji(emoji: "👻", description: "Ghost", isFavorite: false, icon: "v.circle.fill"),
        Emoji(emoji: "👑", description: "Crown", isFavorite: false, icon: "v.circle.fill"),
        Emoji(emoji: "🎩", description: "Hat", isFavorite: false, icon: "v.circle.fill"),
        Emoji(emoji: "🧶", description: "Yarn", isFavorite: false, icon: "v.circle.fill"),
    ]
}
