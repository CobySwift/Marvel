//
//  Comic.swift
//  Marvel
//
//  Created by COBY_PRO on 2023/07/13.
//

import SwiftUI

struct APIComicReseult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
