//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.


import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    // MARK:  UI Elements
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv 
    }()
    
    
    private lazy var searchController : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        return sc
    }()
    
    
    
    
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Searchcontroller Configure
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        //
        
        
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


// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "naber"
        return cell
    }
    
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
