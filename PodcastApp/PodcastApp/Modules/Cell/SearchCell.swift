//
//  SearchCell.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchCell: UITableViewCell{
    
    // MARK:  Properties
    static let reuseID: String = "SearchCell"
    
    
    // MARK: -  UI Elements
    private lazy var photoImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private lazy var artistName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Baran"
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    private lazy var trackName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hayat Amacı"
        lbl.textColor = .label
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    
    private lazy var trackCount: UILabel = {
        let lbl = UILabel()
        lbl.text = "10000 Follow"
        lbl.textColor = .secondaryLabel
        lbl.font = UIFont.preferredFont(forTextStyle: .footnote)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistName,trackName,trackCount])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    // MARK: - İnitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setupUI(){
        drawDesing()
        layout()
    }

    public func configure(with model: SearchResults) {
        setupImage(with: model.artworkUrl600)
        artistName.text = model.artistName
        trackName.text = model.trackName
    }
}


extension SearchCell{
    private func setupImage(with artworkUrl: String?) {
        photoImage.kf.indicatorType = .activity // loading göster
        if let artworkUrl = artworkUrl, let url = URL(string: artworkUrl) {
        
            photoImage.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: { [weak self] result in
                guard let self = self else { return }
                self.photoImage.kf.indicator?.stopAnimatingView() // loading dursun
            })
        } else {
            self.photoImage.kf.indicator?.stopAnimatingView()
            photoImage.image = UIImage(named: "emptyImagePlaceholder") // boş resim göster
        }
    }
}


// MARK: - Layout & DrawDesing
fileprivate extension SearchCell{

    
    func drawDesing(){
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(photoImage)
        contentView.addSubview(vStackView)
    }
    
    func layout(){
        photoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        vStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoImage.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.snp.trailingMargin)
            
        }        
    }
}

