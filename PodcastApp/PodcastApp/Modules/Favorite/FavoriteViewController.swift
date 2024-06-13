//
//  FavoriteViewController.swift
//  PodcastApp
//
//  Created by Baran Baran on 13.06.2024.



import UIKit


protocol FavoriteDisplayLogic: AnyObject {
    
    func display(viewModel: FavoriteModels.Something.ViewModel)
}



final class FavoriteViewController: UIViewController{
    
    // MARK: - Properties
    
    
    // MARK: - UI Elements
    
    private lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    //MARK: - Dependencies
    
    private var interactor : FavoriteBusinessLogic & FavoriteDataStore
    
    private let router : FavoriteRoutingLogic
    
    
    // MARK:  İnitialization
    
    init(interactor: FavoriteBusinessLogic & FavoriteDataStore, router: FavoriteRoutingLogic) {
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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .systemBackground
        
        // subviews
        view.addSubview(collectionView)
        
        // configure collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        
        
    }
    
}


// MARK: - FavoriteDisplayLogic

extension FavoriteViewController: FavoriteDisplayLogic {
    func display(viewModel: FavoriteModels.Something.ViewModel) {
        
    }
}



// MARK: - UICollectionViewDataSource & UICollectionViewDelegate


extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell
        else { return UICollectionViewCell() }
    
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width:((UIScreen.main.bounds.width - 40) / 2) , height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12 , left: 12, bottom: 12, right: 12)
    }
    
}
