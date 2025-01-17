//
//  EpisodeModels.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.
//


import UIKit


enum EpisodeModes {
    
    // fetch api
    enum fetchFeed {
        struct Request {
            let feedUrl: String
        }
        struct Response {
            let feed: [EpisodeResponse]
        }
        struct ViewModel {
            let feed: [EpisodeResponse]
        }
    }
    
   
}
