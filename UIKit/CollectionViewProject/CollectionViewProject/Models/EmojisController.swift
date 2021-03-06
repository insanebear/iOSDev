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
    
    func filteredEmojis(with filters: [String:Int]?=nil, limit: Int?=nil) -> [Emoji] {
        // if no filter, return an original list
        guard let filters = filters else {
            return EmojisController.emojiList
        }
        // if filter, filter out items that match the condition.
        let filteredEmoijs = EmojisController.emojiList.filter { emoji in
            filters[emoji.category] != nil
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
        Emoji(emoji: "π", category: "Fruit", notes: "Apple"),
        Emoji(emoji: "π", category: "Face", notes: "Unamused"),
        Emoji(emoji: "π₯", category: "Fruit", notes: "Kiwi"),
        Emoji(emoji: "π₯", category: "Activity", notes: "3rd"),
        Emoji(emoji: "π", category: "Face", notes: "Smile"),
        Emoji(emoji: "π­", category: "Face", notes: "Crying"),
        Emoji(emoji: "π₯", category: "Activity", notes: "1st"),
        Emoji(emoji: "βΊοΈ", category: "Face", notes: "Blush"),
        Emoji(emoji: "π₯", category: "Activity", notes: "2nd"),
        Emoji(emoji: "π", category: "Fruit", notes: "Strawberry"),
        Emoji(emoji: "π", category: "Activity", notes: "medal"),
        Emoji(emoji: "π", category: "Face", notes: "Frawning"),
    ]
}
#endif
