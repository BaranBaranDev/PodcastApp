//
//  EpisodeBuilder.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.
//

import UIKit




enum EpisodeBuilder {
    static func build(with model: SearchResults) -> EpisodeViewController {
        let worker = EpisodeWorker()
        let presenter = EpisodePresenter()
 
        
        let interactor = EpisodeInteractor(worker: worker, presenter: presenter)
        let router = EpisodeRouter()
        let vc = EpisodeViewController(searchResult: model, interactor: interactor, router: router)
        
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
    }
}
