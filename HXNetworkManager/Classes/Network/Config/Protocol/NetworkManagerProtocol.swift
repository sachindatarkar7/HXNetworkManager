//
//  NetworkManagerProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

protocol NetworkManagerProtocol {
    func startRequest(request: APIData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}
