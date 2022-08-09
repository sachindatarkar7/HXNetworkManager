//
//  APIClientProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation



/// This is use for the get success response
public typealias NetworkSuccessHandler = (Data, URLResponse?) -> Void

/// This is use for the get failer response
public typealias NetworkFailureHandler = (Data?, URLResponse?, NetworkError) -> Void

/// A generic protocol for api calling success or failure response
public protocol APIClientProtocol {
    
    /// This function use for the generic api call
    /// - Parameters:
    ///   - request: make a request using APIData protocol
    ///   - basePath: basePath is base url
    ///   - responseType: responseType is pass response modal
    ///   - keyDecodingStrategy: the strategy to use for automatically changing the value of keys before decoding.
    ///   - completionHandler: pass completion handler with generic data and error
    func fetch<T: Codable>(request: APIData,
                             basePath: String,
                           responseType:T.Type,
                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                             completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
    
    
    
    /// This function use for call normal api
    /// - Parameters:
    ///   - request: make a request using APIData protocol
    ///   - basePath: basePath is base url
    ///   - success: getting success response
    ///   - failure: getting failer response
    func fetch(request: APIData,
               basePath: String,
               success: @escaping NetworkSuccessHandler,
               failure: @escaping NetworkFailureHandler)
}
