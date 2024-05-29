//
//  EpisodeResponse.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.
//

import Foundation
import FeedKit


struct EpisodeResponse: Codable{
    let title: String
    let pubDate: Date
    let description: String
    let imageUrl: String
    let streamUrl: String
    let author: String
    var fileUrl: String?
    
    init(value: RSSFeedItem) {
        self.author = value.iTunes?.iTunesAuthor?.description ?? value.author ?? ""
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.streamUrl = value.enclosure?.attributes?.url ?? ""
        self.description = value.iTunes?.iTunesSubtitle ?? value.description ?? ""
        self.imageUrl = value.iTunes?.iTunesImage?.attributes?.href ?? ""
    }
}
