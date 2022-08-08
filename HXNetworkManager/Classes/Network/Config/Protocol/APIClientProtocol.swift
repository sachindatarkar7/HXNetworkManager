//
//  APIClientProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

typealias NetworkSuccessHandler = (Data, URLResponse?) -> Void
typealias NetworkFailureHandler = (Data?, URLResponse?, NetworkError) -> Void

protocol APIClientProtocol {
    func fetch<T: Codable>(request: APIData,
                             basePath: String,
                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                             completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
    
    func fetch(request: APIData,
               basePath: String,
               success: @escaping NetworkSuccessHandler,
               failure: @escaping NetworkFailureHandler)
}
