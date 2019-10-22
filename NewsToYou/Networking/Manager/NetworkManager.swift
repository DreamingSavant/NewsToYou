//
//  NetworkManager.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/18/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .production
    static let newsApiKey = /*"&apiKey*/ "a716ea821cd5449db8cdacbdcea930aa" // 543444e7d3514e0b980f06ae94e0edaf"
    static let router = Router<NewsApi>()
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated"
        case failed = "Network Request Failed"
        case noData = "Response Returned with no data to decode"
        case unableToDecode = "We could not decode the response"
    }

    enum Result<String> {
        case success
        case failure(String)
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...499: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getNewArticles(/*page: Int?,*/ completion: @escaping (_ newsArticle: [NewsModel]?,_ error: String?)->()){

        NetworkManager.router.request(.topHeadlines/*(page: page)*/) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(NewsResponse.self, from: responseData)
                        completion(apiResponse.articles, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}


