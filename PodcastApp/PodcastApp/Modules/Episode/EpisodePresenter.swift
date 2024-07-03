//
//  EpisodePresenter.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.
//


protocol EpisodePresentationLogic {
    func presentFetchFeed(response: EpisodeModes.fetchFeed.Response)
  
}


final class EpisodePresenter {
    weak var controller: EpisodeDisplayLogic?
}


extension EpisodePresenter: EpisodePresentationLogic{
    
    func presentFetchFeed(response: EpisodeModes.fetchFeed.Response) {
        controller?.displayFetchFeedData(viewModel: EpisodeModes.fetchFeed.ViewModel(feed: response.feed))
    }
    


}
