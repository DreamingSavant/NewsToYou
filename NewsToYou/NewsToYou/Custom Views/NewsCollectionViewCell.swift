//
//  NewsCollectionViewCell.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/18/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    static let identifier = "NewsCollectionViewCell"
    
    var newsData: NewsModel! {
        didSet {
            articleTitleLabel.text = newsData.title
            guard let image = newsData.urlToImage else {return}
            CacheManager.shared.downloadImage(image) { [weak self] dat in
                if let data = dat {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    
}
