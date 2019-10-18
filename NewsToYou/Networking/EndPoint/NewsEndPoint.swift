//
//  NewsEndPoint.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum NewsApi {
    case topHeadlines//(page:Int)
    case allNews//(page:Int)
}

extension NewsApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://newsapi.org/v2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines?country=us"
        case .allNews:
            return "everything?q=Apple?from=2019-10-18?sortBy=popularity"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .topHeadlines:
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [/*"page":page,*/
                                                "api_Key":NetworkManager.newsApiKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
