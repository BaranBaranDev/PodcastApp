//
//  EpisodeCell.swift
//  PodcastApp
//
//  Created by Baran Baran on 29.05.2024.
//


import UIKit
import SnapKit
import SDWebImage

final class EpisodeCell: UITableViewCell{
    
    // MARK:  Properties
    static let reuseID: String = "EpisodeCell"
    
    
    // MARK: -  UI Elements
    private lazy var photoImage : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 4
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    
    private lazy var pubDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .secondaryLabel
        lbl.font = UIFont.preferredFont(forTextStyle: .footnote)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel,pubDateLabel])
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
        photoImage.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        pubDateLabel.text = nil
    }
    
    // MARK: - Helpers
    
    private func setupUI(){
        drawDesing()
        layout()
    }
    
    
    public func configure(with model : EpisodeResponse){
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        setupImage(with: model.imageUrl)
        setupPubDate(with: model.pubDate)
    }
}

// MARK: - Layout & DrawDesing
fileprivate extension EpisodeCell{
    
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

// MARK: - EpisodeCell+UIConfiguration

extension EpisodeCell {
    
    // Görsel ayarları
    private func setupImage(with imageUrl: String?) {
        photoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            photoImage.sd_setImage(with: nil, placeholderImage: UIImage(named: "emptyImagePlaceholder"))
            return
        }
        
        photoImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.photoImage.sd_imageIndicator?.stopAnimatingIndicator()
        })
    }
    
    // Tarih formatı
    private func setupPubDate(with pubDate: Date?) {
        guard let pubDate = pubDate else { return }
        
        // PubDate'i hedef tarih formatına dönüştürmek için DateFormatter kullanılır
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // Hedef tarih formatı
        
        // PubDate'i hedef tarih formatına dönüştürülür
        let formattedPubDate = dateFormatter.string(from: pubDate)
        pubDateLabel.text = formattedPubDate
    }

}

