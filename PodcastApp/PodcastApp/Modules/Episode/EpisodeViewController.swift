//
//  EpisodeViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.


import UIKit
import SnapKit


protocol EpisodeDisplayLogic: AnyObject {
    func displayFetchFeedData(viewModel: Episode.fetchFeed.ViewModel)
}


final class EpisodeViewController: UIViewController {
    
    // MARK:  Properties
    private var episodeArray: [EpisodeResponse] = []
    private var searchResult: SearchResults?

    
    //MARK: Dependencies
    private var interactor: EpisodeBusinessLogic & EpisodeDataStore
    private let router: EpisodeRoutingLogic
    
    
    // MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    
    
    
    
    // MARK: - İnitialization
    
    
    init(searchResult: SearchResults? = nil, interactor: EpisodeBusinessLogic & EpisodeDataStore, router: EpisodeRoutingLogic) {
        self.searchResult = searchResult
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        // kontrol
        guard let feedUrl = searchResult?.feedUrl else { return }
        // başlar başlamaz gelen feedUrl verisini çekelim 
        interactor.fetchFeedData(request: Episode.fetchFeed.Request(feedUrl: feedUrl))
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseID)
        
        
       // NavBar Configure
        navigationItem.title = searchResult?.trackName

        
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


// MARK: - EpisodeDisplayLogic

extension EpisodeViewController: EpisodeDisplayLogic {
    func displayFetchFeedData(viewModel: Episode.fetchFeed.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.episodeArray = viewModel.feed
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseID, for: indexPath) as? EpisodeCell else{ return UITableViewCell()}
       
        let model = episodeArray[indexPath.item]
        cell.configure(with: model)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenHeight / 5
    }
    
    // hücre tıklanırsa
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // aktarılacak veri dolduruldu
        interactor.episodeResponse = episodeArray[indexPath.item]
        // Geçiş
        router.routePlay()
    }

    
    
}
