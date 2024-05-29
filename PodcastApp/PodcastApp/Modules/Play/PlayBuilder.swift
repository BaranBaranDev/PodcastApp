//
//  PlayBuilder.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.
//

import Foundation


enum PlayBuilder {
    static func build(with model: EpisodeResponse) -> PlayViewController {
        let vc = PlayViewController(episode: model)
        return vc
    }
}
