//
//  SearchRouter.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.


protocol SearchRoutingLogic {
    func routeEpisode()
}

protocol SearchDataPassing: AnyObject {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter : SearchDataPassing {
    var dataStore: SearchDataStore?
    
    weak var controller : SearchViewController?
}


extension SearchRouter: SearchRoutingLogic {
    func routeEpisode() {
        guard let selectedPodcast = dataStore?.selectedPodcast else { return } // SearchResults

        
        let vc = EpisodeBuilder.build(with: selectedPodcast)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
