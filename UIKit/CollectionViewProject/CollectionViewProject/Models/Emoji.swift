//
//  Emoji.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/17.
//

import Foundation

struct Emoji {
    let emoji: String
    let category: String
    let notes: String
}

#if DEBUG
extension Emoji {
    static let emojiList: [Emoji] = [
        Emoji(emoji: "🍎", category: "Fruit", notes: "Apple"),
        Emoji(emoji: "🍓", category: "Fruit", notes: "Strawberry"),
        Emoji(emoji: "🥝", category: "Fruit", notes: "Kiwi"),
        Emoji(emoji: "😀", category: "Face", notes: "Smile"),
        Emoji(emoji: "🙁", category: "Face", notes: "Frawning"),
        Emoji(emoji: "☺️", category: "Face", notes: "Blush"),
        Emoji(emoji: "😒", category: "Face", notes: "Unamused"),
        Emoji(emoji: "😭", category: "Face", notes: "Crying"),
        Emoji(emoji: "🥇", category: "Activity", notes: "1st"),
        Emoji(emoji: "🥈", category: "Activity", notes: "2nd"),
        Emoji(emoji: "🥉", category: "Activity", notes: "3rd"),
        Emoji(emoji: "🏅", category: "Activity", notes: "medal"),
    ]
}
#endif
