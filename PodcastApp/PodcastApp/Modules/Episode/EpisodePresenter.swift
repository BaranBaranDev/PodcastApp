//
//  EpisodePresenter.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.
//


protocol EpisodePresentationLogic {
    func presenterFetchFeed(response: Episode.fetchFeed.Response)
}


final class EpisodePresenter {
    weak var controller: EpisodeDisplayLogic?
}


extension EpisodePresenter: EpisodePresentationLogic{
    func presenterFetchFeed(response: Episode.fetchFeed.Response) {
        
        controller?.displayFetchFeedData(viewModel: Episode.fetchFeed.ViewModel(feed: response.feed))
    }
}
