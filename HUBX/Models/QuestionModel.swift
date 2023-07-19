//
//  Model.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation

struct Question: Codable {
    let id: Int?
    let title, subtitle: String?
    let image_uri: String?
    let uri: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case image_uri = "image_uri"
        case uri, order
    }
}
typealias Questions = [Question]


