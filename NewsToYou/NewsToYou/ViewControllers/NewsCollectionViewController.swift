//
//  FirstViewController.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import UIKit

class NewsCollectionViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var networkManager = NetworkManager()
    var newsModels = [NewsModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getNewsArticles()
        collectionView.reloadData()
    }
    
    func getNewsArticles(){
        networkManager.getNewArticles(/*page: nil*/) { [weak self] articles, error in
            if let error = error {
                print(error)
            }
            if let articles = articles {
                self?.newsModels = articles
                print("Number of articles: \(articles.count)")
            }
        }
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: NewsCollectionViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
}

extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
        let newsCellAtRow = newsModels[indexPath.row]
        cell.newsData = newsCellAtRow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsForRow = newsModels[indexPath.row]
        let detailNewsController = storyboard?.instantiateViewController(identifier: "DetailedNewsController") as! DetailedNewsController
        detailNewsController.currentNewsArticle = newsForRow
        navigationController?.pushViewController(detailNewsController, animated: true)
    }
    

}

