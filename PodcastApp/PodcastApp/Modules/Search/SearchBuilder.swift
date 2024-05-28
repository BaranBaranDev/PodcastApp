//
//  SearchBuilder.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import Foundation


enum SearchBuilder {
    static func build() -> SearchViewController {
        let service = ServiceManager()
        let worker = SearchWorker(service: service)
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(networkWorker: worker, presenter: presenter)
        let router = SearchRouter()
        let vc = SearchViewController(interactor: interactor, router: router)
        
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
    }
}
