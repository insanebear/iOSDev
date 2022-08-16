//
//  Image.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/16.
//

import Foundation

struct ImageData: Decodable {
    let results: [Image]
}

struct Image: Decodable {
    let id: String
    let urls: URLs
}
struct URLs: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
