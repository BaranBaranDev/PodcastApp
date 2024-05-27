//
//  ApiURL.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import Foundation



enum ApiURL {
    static func searchPodcast(searchText: String) -> String {
        let url = "https://itunes.apple.com/search?media=podcast&term={\(searchText)}"
        return url
    }
}
