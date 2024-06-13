//
//  FavoriteBuilder.swift
//  PodcastApp
//
//  Created by Baran Baran on 13.06.2024.
//


import Foundation


enum FavoriteBuilder {
    static func build() -> FavoriteViewController {
        let worker = FavoriteWorker()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        let interactor = FavoriteInteractor(presenter: presenter, worker: worker)
        let vc = FavoriteViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

