//
//  HTTPTask.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
    
    //case download, upload....etc
}
