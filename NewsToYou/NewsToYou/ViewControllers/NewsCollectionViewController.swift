//
//  FirstViewController.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import UIKit

class NewsCollectionViewController: UIViewController {

    var networkManager = NetworkManager()
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.getNewArticles(/*page: nil*/) { articles, error in
            if let error = error {
                print(error)
            }
            if let articles = articles {
                print(articles)
            }
        }
    }


}

