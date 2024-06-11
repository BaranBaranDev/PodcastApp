//
//  UIImageView+Ext.swift
//  PodcastApp
//
//  Created by Baran Baran on 11.06.2024.
//

import UIKit
import SDWebImage


extension UIImageView {
    
    func downloadImage(with urlString: String) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        guard let url = URL(string: urlString) else { return }
        
        self.sd_setImage(with: url, placeholderImage: nil, options: [.scaleDownLargeImages, .avoidAutoSetImage]) { [weak self] (image, error, cacheType, url) in
            guard let self = self else { return }
            if let image = image {
                let resizedImage = image.sd_resizedImage(with: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
                self.sd_imageIndicator?.stopAnimatingIndicator()
                self.image = resizedImage
            }
        }
    }
}
