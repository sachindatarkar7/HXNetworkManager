//
//  NetworkManagerProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation


/// Implement this protocol in Network manager class
public protocol NetworkManagerProtocol {
    /// This function use in the network manager class for api call
    /// - Parameters:
    ///   - request: make request from APIData protocol
    ///   - basePath: basePath is base  url
    ///   - completion: completion with  data ,response , error
    func startRequest(request: APIData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}
