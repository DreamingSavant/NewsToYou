//
//  NetworkRouter.swift
//  NewsToYou
//
//  Created by Roderick Presswood on 10/17/19.
//  Copyright © 2019 Roderick Presswood. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) ->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
