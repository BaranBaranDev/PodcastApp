//
//  SearchInteractor.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.



protocol SearchBusinessLogic {
    func searchPodcast(request: Search.searchPodcast.Request)
}



final class SearchInteractor{
    
    //MARK: Dependencies
    private let networkWorker: SearchNetworkWorker
    private let presenter : SearchPresentationLogic
    
    init(networkWorker: SearchNetworkWorker, presenter: SearchPresentationLogic) {
        self.networkWorker = networkWorker
        self.presenter = presenter
    }
    
}


extension SearchInteractor: SearchBusinessLogic {
    func searchPodcast(request: Search.searchPodcast.Request) {
        networkWorker.searchPodcast(searchText: request.query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let searchResponse):
                presenter.presenterSearchPodcast(response: Search.searchPodcast.Response(podcasts: searchResponse.results))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

