//
//  videosResponse.swift
//  MovieAppExample
//
//  Created by Ensar on 20.06.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoResponse = try? JSONDecoder().decode(VideoResponse.self, from: jsonData)

import Foundation

// MARK: - VideosResponse
struct VideosResponse: Codable {
    let id: Int?
    let results: [Video]?
}

// MARK: - Video
struct Video: Codable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

