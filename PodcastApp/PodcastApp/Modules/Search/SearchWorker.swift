//
//  SearchWorker.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.


protocol SearchNetworkWorker {
    func searchPodcast(searchText: String, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}

final class SearchWorker { 
     //MARK: Dependencies
    private let service: ServiceManagerProtocol
    
    init(service: ServiceManagerProtocol) {
        self.service = service
    }
}

extension SearchWorker: SearchNetworkWorker {
    func searchPodcast(searchText: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let url = ApiURL.searchPodcast(searchText: searchText)
        service.fetchData(url: url, completion: completion)
    }
}
