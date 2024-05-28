//
//  SearchPresenter.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//


protocol SearchPresentationLogic {
    func presenterSearchPodcast(response: Search.searchPodcast.Response)
}



final class SearchPresenter {
    weak var controller : SearchDisplayLogic?
}

extension SearchPresenter: SearchPresentationLogic {
    func presenterSearchPodcast(response: Search.searchPodcast.Response) {
        controller?.displaySearchPodcast(viewModel: Search.searchPodcast.ViewModel(podcast: response.podcasts))
    }
}
