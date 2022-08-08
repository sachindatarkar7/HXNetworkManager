//
//  APIClientProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

public typealias NetworkSuccessHandler = (Data, URLResponse?) -> Void
public typealias NetworkFailureHandler = (Data?, URLResponse?, NetworkError) -> Void

public protocol APIClientProtocol {
    func fetch<T: Codable>(request: APIData,
                             basePath: String,
                           responseType:T.Type,
                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                             completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
    
    func fetch(request: APIData,
               basePath: String,
               success: @escaping NetworkSuccessHandler,
               failure: @escaping NetworkFailureHandler)
}
