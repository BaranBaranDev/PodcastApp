//
//  PlayViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.


import UIKit


final class PlayViewController: UIViewController {
    
    // MARK: - Properties
    private var episode: EpisodeResponse?
    
    
    
    // MARK: - UI Elements
   
    private lazy var  playView : UIView = PlayView()
    
    
    // MARK: - İnitialization
    
    init(episode: EpisodeResponse? = nil) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
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
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(playView)
    }
    
    private func layout (){
        playView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)

        }
    }
}

