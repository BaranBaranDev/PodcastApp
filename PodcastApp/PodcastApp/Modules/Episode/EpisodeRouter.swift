//
//  EpisodeRouter.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.


protocol EpisodeRoutingLogic {
    func routePlay()
}

protocol EpisodeDataPassing: AnyObject {
    var dataStore: EpisodeDataStore? { get }
}


final class EpisodeRouter: EpisodeDataPassing {
    
    //MARK: Public Properties
    
    var dataStore: EpisodeDataStore?
    weak var controller: EpisodeViewController?
}


extension EpisodeRouter: EpisodeRoutingLogic {
    
    //MARK: Routing Logic
    
    func routePlay() {
        guard let selectedEpisodeData = dataStore?.episodeResponse else { return }
        let vc = PlayViewController(episode: selectedEpisodeData)
        controller?.present(vc, animated: true)
    }
    
}

