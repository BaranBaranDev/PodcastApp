//
//  EpisodeInteractor.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.

import Foundation
import CoreData



protocol EpisodeBusinessLogic {
    func fetchFeedData(request: EpisodeModes.fetchFeed.Request)
    
}

protocol EpisodeDataStore {
    var episodeResponse: EpisodeResponse? { get set } // Taşımak istediğim
}


final class EpisodeInteractor: EpisodeDataStore {
    
    // EpisodeDataStore Logic
    var episodeResponse: EpisodeResponse?
    
    
    //MARK: Dependencies
    
    typealias WorkerType = EpisodeNetworkWorker & EpisodeCoreDataWorker
    
    private let worker: WorkerType
    private let presenter: EpisodePresentationLogic

     init(worker: WorkerType, presenter: EpisodePresentationLogic) {
         self.worker = worker
         self.presenter = presenter
     }
    
}




extension EpisodeInteractor: EpisodeBusinessLogic {

    
    func fetchFeedData(request: EpisodeModes.fetchFeed.Request) {
        worker.fetchData(urlString: request.feedUrl) { [weak self] episodeResponse in
            guard let self = self else { return }
            presenter.presentFetchFeed(response: EpisodeModes.fetchFeed.Response(feed: episodeResponse))
        }
    }
    
}
