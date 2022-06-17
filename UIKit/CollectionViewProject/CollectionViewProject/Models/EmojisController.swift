//
//  EmojisController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/17.
//

import Foundation

class EmojisController {
    struct Emoji: Hashable {
        let emoji: String
        let category: String
        let notes: String
    }
    
    func filteredEmojis(with filter: String?=nil, limit: Int?=nil) -> [Emoji] {
        // if no filter, return an original list
        if filter == nil {
            return EmojisController.emojiList
        }
        
        // if filter, filter out items that match the condition.
        let filteredEmoijs = EmojisController.emojiList.filter { emoji in
            emoji.category == filter
        }
        if let limit = limit {
            return Array(filteredEmoijs.prefix(through: limit))
        } else {
            return filteredEmoijs
        }
                                                                
    }
}

#if DEBUG
extension EmojisController {
    static let emojiList: [Emoji] = [
        Emoji(emoji: "🍎", category: "Fruit", notes: "Apple"),
        Emoji(emoji: "😒", category: "Face", notes: "Unamused"),
        Emoji(emoji: "🥝", category: "Fruit", notes: "Kiwi"),
        Emoji(emoji: "🥉", category: "Activity", notes: "3rd"),
        Emoji(emoji: "😀", category: "Face", notes: "Smile"),
        Emoji(emoji: "😭", category: "Face", notes: "Crying"),
        Emoji(emoji: "🥇", category: "Activity", notes: "1st"),
        Emoji(emoji: "☺️", category: "Face", notes: "Blush"),
        Emoji(emoji: "🥈", category: "Activity", notes: "2nd"),
        Emoji(emoji: "🍓", category: "Fruit", notes: "Strawberry"),
        Emoji(emoji: "🏅", category: "Activity", notes: "medal"),
        Emoji(emoji: "🙁", category: "Face", notes: "Frawning"),
    ]
}
#endif
