//
//  SearchInteractor.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.



protocol SearchBusinessLogic {
    func searchPodcast(request: Search.searchPodcast.Request)
}

protocol SearchDataStore: AnyObject {
    var selectedPodcast: SearchResults? { get set } // aktarmalıyız episode sayfasına
}


final class SearchInteractor : SearchDataStore{

    // MARK: SearchDataStore logic
    var selectedPodcast: SearchResults?

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


