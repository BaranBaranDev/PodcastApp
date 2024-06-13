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
        let cv = UICollectionView()
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
}
