//
//  SearchWorker.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.


protocol SearchNetworkWorker {
    func searchPodcast(searchText: String, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}

final class SearchWorker { }

extension SearchWorker: SearchNetworkWorker {
    func searchPodcast(searchText: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let url = ApiURL.searchPodcast(searchText: searchText)
        ServiceManager.shared.fetchData(url: url, completion: completion)
    }
}
