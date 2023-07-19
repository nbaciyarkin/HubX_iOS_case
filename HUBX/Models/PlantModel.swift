//
//  PlantModel.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 19.07.2023.
//

import Foundation



// MARK: - Datum
struct Plants: Codable {
    let data: [Plant]
    let meta: Meta?
}

// MARK: - Datum
struct Plant: Codable {
    let id: Int?
    let name, createdAt, updatedAt, publishedAt: String?
    let title: String?
    let rank: Int?
    let image: Image?
}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let name: String?
    let alternativeText, caption: JSONNull?
    let width, height: Int?
    let formats: JSONNull?
    let hash, ext, mime: String?
    let size: Double?
    let url: String?
    let previewURL: JSONNull?
    let provider: String?
    let providerMetadata: JSONNull?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, alternativeText, caption, width, height, formats, hash, ext, mime, size, url
        case previewURL
        case provider
        case providerMetadata
        case createdAt, updatedAt
    }
}


// MARK: - Meta
struct Meta: Codable {
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let page, pageSize, pageCount, total: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
