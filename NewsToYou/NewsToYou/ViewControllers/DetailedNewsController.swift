//
//  DetailedNewsController.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/18/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import UIKit

class DetailedNewsController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    
    var currentNewsArticle: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let currentNews = currentNewsArticle, let publisingDate = currentNews.publishedAt, let content = currentNews.content else {return}
        self.title = currentNews.title
        titleLabel.text = currentNews.title
        contentView.text = "Created By: \(currentNews.author ?? "No Author")\nPublished On: \(publisingDate) \n\n \(content)"
        guard let image = currentNewsArticle.urlToImage else {return}
        CacheManager.shared.downloadImage(image) { (dat) in
            if let data = dat {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}
