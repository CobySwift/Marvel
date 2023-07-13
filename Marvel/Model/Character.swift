//
//  Character.swift
//  Marvel
//
//  Created by COBY_PRO on 2023/07/13.
//

import SwiftUI

// Model...

struct APIReseult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
