//
//  PlayView.swift
//  PodcastApp
//
//  Created by Baran Baran on 11.06.2024.
//

import UIKit

final class PlayView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var cloneButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)     
        return btn
    }()
    
    private lazy var episodeImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var slider: UISlider = {
        let sld = UISlider()
        sld.setThumbImage(UIImage(), for: .normal)
        return sld
    }()
    
    private lazy var startLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "00.00"
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var endLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "00.00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    
    private lazy var podcastName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Label"
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    private lazy var userName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Label"
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    private lazy var horizantalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startLabel,endLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var fullStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cloneButton,episodeImage,slider,horizantalStack,podcastName,userName])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    // MARK: - İnitialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Helpers

private extension PlayView {
    
     func setup(){
        // background
         backgroundColor = .systemBackground
        
        //subviews
        addSubview(horizantalStack)
        addSubview(fullStackView)
        
    }

     func layout(){
        
        fullStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(self.snp.leadingMargin)
            make.trailing.equalTo(self.snp.trailingMargin)
        }
        
        cloneButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 32).isActive = true
        episodeImage.heightAnchor.constraint(equalToConstant: 250).isActive = true

    }
}
