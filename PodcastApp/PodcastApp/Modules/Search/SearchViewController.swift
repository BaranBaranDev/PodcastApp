//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.


import UIKit
import SnapKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearchPodcast(viewModel: Search.searchPodcast.ViewModel)
}


final class SearchViewController: UIViewController {
    
    // MARK: Properties
    private var searchPodcastsArray: [SearchResults] = []
    typealias SearchInteractorLogic = (SearchBusinessLogic & SearchDataStore)
    
    //MARK: Dependencies
   
    private let interactor: SearchInteractorLogic
    private let router: SearchRoutingLogic
    
    // MARK: - UI  Elements
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    
    private lazy var searchController : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        return sc
    }()
    
    // MARK: - İnitialization
    
    init(interactor: SearchInteractorLogic, router: SearchRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    
    
    // MARK: - Setup
    private func setup(){
        // Subview
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        
        // Tableview Configure
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseID)
        
        // Searchcontroller Configure
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
    }
    
    // MARK: Layout
    private func layout(){
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}


// MARK: - SearchViewControllerDisplayLogic
extension SearchViewController: SearchDisplayLogic {
    // presentardan gelenleri işleriz
    func displaySearchPodcast(viewModel: Search.searchPodcast.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchPodcastsArray = viewModel.podcast
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPodcastsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseID, for: indexPath) as? SearchCell else{ return UITableViewCell()}
        
        let model = searchPodcastsArray[indexPath.item]
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenHeight / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // interactorda transfer edeceğimiz selectedPodcast ayarlıyoruz
        interactor.selectedPodcast = searchPodcastsArray[indexPath.item]
        
        router.routeEpisode() // geçiş
    }
    
    
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // parametreyi interactora yollarız
        interactor.searchPodcast(request: Search.searchPodcast.Request(query: searchText))
    }
}
