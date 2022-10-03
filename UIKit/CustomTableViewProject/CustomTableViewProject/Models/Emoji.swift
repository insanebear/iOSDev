//
//  Emoji.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/22.
//

import Foundation

struct Emoji: Equatable, Identifiable, Hashable {
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
    static var emojis: [Emoji] = [
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
        Emoji(emoji: "⚾️", description: "Baseball", isFavorite: false, icon: "v.circle.fill"),
        Emoji(emoji: "🥏", description: "Frisbee", isFavorite: false, icon: "v.circle.fill"),
        Emoji(emoji: "🏉", description: "Rugbyball", isFavorite: true, icon: "v.circle.fill"),
        Emoji(emoji: "🏐", description: "Volleyball", isFavorite: false, icon: "v.circle.fill"),
    ]
    
    static func insert(_ emoji: Emoji, at index: Int) {
        Emoji.emojis.insert(emoji, at: index)
    }
    
    static func update(emoji: Emoji) {
        let index = emojis.indexOfEmoji(with: emoji.id)
        emojis[index] = emoji
    }
    
    static func remove(emoji: Emoji) {
        let index = emojis.indexOfEmoji(with: emoji.id)
        emojis.remove(at: index)
    }
    
    static func reorder(emojiToMove: Emoji, emojiAtDestination: Emoji) {
        let destinationIndex = emojis.firstIndex(of: emojiAtDestination) ?? 0
        emojis.removeAll(where: {$0.id == emojiToMove.id})
        emojis.insert(emojiToMove, at: destinationIndex)
    }
}
