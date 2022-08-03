//
//  CardView+Enum.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

enum FilmType: CaseIterable {
    case noFilm
    case gradient
    case fill60
    case fill40
    
    func getColoredFilm(color: UIColor) -> (CGColor, CGColor) {
        switch self {
        case .noFilm:
            return (UIColor.clear.withAlphaComponent(0).cgColor,
                    UIColor.clear.withAlphaComponent(0).cgColor)
        case .gradient:
            return (UIColor.clear.withAlphaComponent(0).cgColor,
                    color.withAlphaComponent(1).cgColor)
        case .fill60:
            return (color.withAlphaComponent(0.6).cgColor,
                    color.withAlphaComponent(0.6).cgColor)
        case .fill40:
            return (color.withAlphaComponent(0.4).cgColor,
                    color.withAlphaComponent(0.4).cgColor)
        }
    }
}

enum CardType: CaseIterable {
    case noResource
    case noText
    case normal // resource + text
}
