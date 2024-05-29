//
//  EpisodeWorker.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.


import UIKit
import FeedKit

protocol EpisodeNetworkWorker {
    func fetchData(urlString: String, completion: @escaping([EpisodeResponse]) -> Void)
}


struct EpisodeWorker: EpisodeNetworkWorker {
    func fetchData(urlString: String, completion: @escaping ([EpisodeResponse]) -> Void) {
        var episodeResult: [EpisodeResponse] = []
        
        guard let url = URL(string: urlString) else { return }
        
        // FeedParser nesnesi oluşturulur
        let feedParser = FeedParser(URL: url)
        
        // Asenkron olarak besleme verisi parse edilir
        feedParser.parseAsync { result in
            switch result {
            case .success(let feed):
                switch feed {
                case .atom(_):
                    break
                    
                case .rss(let feedResult):
                    // RSS feed içeriği işlenir
                    feedResult.items?.forEach { value in
                        let episode = EpisodeResponse(value: value)
                        episodeResult.append(episode)
                    }
                    completion(episodeResult)
                    
                case .json(_):
                    break
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


