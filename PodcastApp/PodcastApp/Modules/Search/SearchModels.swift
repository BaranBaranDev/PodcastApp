//
//  SearchModels.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//


import UIKit

enum Search {
    enum searchPodcast {
        struct Request {
            let query: String
        }
        struct Response {
            let podcasts: [SearchResults]
        }
        struct ViewModel {
            let podcast: [SearchResults]
        }
    }
}
