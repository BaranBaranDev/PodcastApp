//
//  SearchResponse.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import Foundation


struct SearchResponse: Codable {
    let resultCount: Int
    let results: [SearchResults]
}

struct SearchResults: Codable {
    let artistName: String
    let trackName: String?
    let trackCount: Int?
    let artworkUrl600: String?
    let feedUrl: String?
}
