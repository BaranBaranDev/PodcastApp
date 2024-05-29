//
//  PlayViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.


import UIKit


final class PlayViewController: UIViewController {
    
    // MARK: - Properties
    private var episode: EpisodeResponse?
    
    
    
    
    // MARK: - İnitialization
    
    init(episode: EpisodeResponse? = nil) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        print(episode?.title)
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
        view.backgroundColor = .cyan
        
    }
    
    // MARK: Layout
    private func layout(){
    
    }
}

