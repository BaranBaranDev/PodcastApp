//
//  EpisodeViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 28.05.2024.


import UIKit




import SnapKit

protocol EpisodeDisplayLogic: AnyObject {
    
}


final class EpisodeViewController: UIViewController {
    
    // MARK: - Properties
    
    public var searchResult: SearchResults?
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    
    
    // MARK: - Setup
    private func setup(){
        view.backgroundColor = .systemBackground
        navigationItem.title = searchResult?.trackName
    }
    
    // MARK: Layout
    private func layout(){
        
    }
}


