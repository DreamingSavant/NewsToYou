//
//  CacheManager.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/22/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

final class CacheManager {
    
    // MARK: - Shared Instance
    static let shared = CacheManager()
    
    // MARK: - Properties
    private let cache = NSCache<NSString, NSData>()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Method
    
    func downloadImage(_ endpoint: String,
                       _ completion: @escaping (Data?)->()) {
        
        if let nsData = cache.object(forKey: endpoint as NSString ) {
        completion(nsData as Data)
        return
        }
        
        
        //check that we can instantiate an URL from the url string, else return
        guard let url = URL(string: endpoint) else {
        completion(nil)
        return
        }
        
        
        URLSession.shared.dataTask(with: url) { (dat, _,_) in
        
        guard let data = dat else {
        completion(nil)
        return
        }

            self.cache.setObject(data as NSData, forKey: endpoint as NSString)

        DispatchQueue.main.async {
        completion(data)
        }
        //call resume() on task to fire
        }.resume()
    }
}
