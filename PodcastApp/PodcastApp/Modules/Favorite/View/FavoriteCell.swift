//
//  FavoriteCell.swift
//  PodcastApp
//
//  Created by Baran Baran on 13.06.2024.
//
import UIKit
import SnapKit


final class FavoriteCell: UICollectionViewCell {
   
    // MARK: - Properties
    
    static let reuseID: String = "FavoriteCell"
    
    
    // MARK: -  UI Elements
    
    private lazy var photoImage : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .red
        return iv
    }()
    
    private lazy var podcastName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "podcastName"
        return lbl
    }()
    
    private lazy var artistName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.preferredFont(forTextStyle: .footnote)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "artistName"
        return lbl
    }()
    
   
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImage,podcastName,artistName])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(vStackView)
        
    }
    
    // MARK:  Layout
    private func layout() {
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        photoImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(contentView.bounds.height / 2 )
        }
    }
}

