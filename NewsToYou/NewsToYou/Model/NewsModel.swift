//
//  NewsDataModel.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

struct NewsResponse {
    let numberOfResults: Int
    let articles: [NewsModel]
}

struct NewsModel: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var url: String?
    
    private enum NewsCodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let articleContainer = try decoder.container(keyedBy: NewsCodingKeys.self)
        
        author = try articleContainer.decodeIfPresent(String.self, forKey: .author)
        title = try articleContainer.decodeIfPresent(String.self, forKey: .title)
        description = try articleContainer.decodeIfPresent(String.self, forKey: .description)
        urlToImage = try articleContainer.decodeIfPresent(String.self, forKey: .urlToImage)
        publishedAt = try articleContainer.decodeIfPresent(String.self, forKey: .publishedAt)
        content = try articleContainer.decodeIfPresent(String.self, forKey: .content)
        url = try articleContainer.decodeIfPresent(String.self, forKey: .url)
    }
}

extension NewsResponse: Decodable {
    
    private enum NewsApiResponseCodingKeys: String, CodingKey {
//        case page
        case numberOfResults = "totalResults"
//        case numberOfPages = "total_pages"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsApiResponseCodingKeys.self)
        
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        articles = try container.decode([NewsModel].self, forKey: .articles)
        
    }
}
