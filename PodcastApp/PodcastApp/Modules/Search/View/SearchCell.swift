//
//  SearchCell.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import UIKit
import SnapKit
import SDWebImage

final class SearchCell: UITableViewCell{
    
    // MARK:  Properties
    static let reuseID: String = "SearchCell"
    
    
    // MARK: -  UI Elements
    private lazy var photoImage : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private lazy var artistName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var trackName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    
    private lazy var trackCount: UILabel = {
        let lbl = UILabel()
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
    

    override func prepareForReuse() {
        super.prepareForReuse()
        // Hücreleri yeniden kullanmadan önce temizleyelim 
        photoImage.image = nil
        artistName.text = nil
        trackName.text = nil
        trackCount.text = nil
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
        trackCount.text = "\(model.trackCount ?? 0) Follow"
    }
}


extension SearchCell {
    private func setupImage(with artworkUrl: String?) {
        photoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray // loading göster
        guard let artworkUrl = artworkUrl, let url = URL(string: artworkUrl) else {
            // Boş veya geçersiz bir URL ise, boş resmi göster ve loading indicator'ı durdur
            photoImage.sd_setImage(with: nil, placeholderImage: UIImage(named: "emptyImagePlaceholder"))
            return
        }
        
        photoImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: { [weak self] _, _, _, _ in
            // Resim yüklenme tamamlandığında
            guard let self = self else { return }
            self.photoImage.sd_imageIndicator?.stopAnimatingIndicator()
        })
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

