//
//  EpisodeInteractor.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.


protocol EpisodeBusinessLogic {
    func fetchFeedData(request: Episode.fetchFeed.Request)
}

protocol EpisodeDataStore {
    var episodeResponse: EpisodeResponse? { get set } // Taşımak istediğim
}


final class EpisodeInteractor: EpisodeDataStore {
    
    // EpisodeDataStore Logic
    var episodeResponse: EpisodeResponse?
    
    
     //MARK: Dependencies
    
    private let worker: EpisodeNetworkWorker
    private let presenter: EpisodePresentationLogic
    
    init(worker: EpisodeNetworkWorker, presenter: EpisodePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
}




extension EpisodeInteractor: EpisodeBusinessLogic {
    func fetchFeedData(request: Episode.fetchFeed.Request) {
        worker.fetchData(urlString: request.feedUrl) { [weak self] episodeResponse in
            guard let self = self else { return }
            presenter.presenterFetchFeed(response: Episode.fetchFeed.Response(feed: episodeResponse))
        }
    }
    
}
