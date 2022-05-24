//
//  Emoji.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import Foundation

struct Emoji {
    var emoji: String
    var description: String
}

extension Emoji {
    static var sampleEmojis: [Emoji] = [
        Emoji(emoji: "🤔", description: "Hmm"),
        Emoji(emoji: "🎉", description: "Tada"),
        Emoji(emoji: "🙇‍♂️", description: "Bow"),
        Emoji(emoji: "🐈", description: "Cat"),
    ]
}
