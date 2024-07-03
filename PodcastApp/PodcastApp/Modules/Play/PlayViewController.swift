//
//  PlayViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.


import UIKit
import SDWebImage

final class PlayViewController: UIViewController {
    
    // MARK: - Properties
    private var episode: EpisodeResponse?

    // MARK: - UI Elements
   
    private lazy var  playView : UIView = {
        let view = PlayView(frame: .zero, episodeModel: episode!)

        view.closeAction = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        return view
    }()
    
    
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
    
    // Bellek
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.shared.clearMemory()
        if (self.isViewLoaded) && (self.view.window == nil) {
            self.view = nil
        }
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

