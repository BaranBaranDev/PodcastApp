//
//  EpisodeBuilder.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.
//

import Foundation




enum EpisodeBuilder {
    static func build(with model: SearchResults) -> EpisodeViewController {
     
        let vc = EpisodeViewController()
        vc.searchResult = model
        return vc
    }
}
