//
//  APIDataProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//

import Foundation

/// This protocol use for the creating api request
public protocol APIData {
    /// path is use for api path
    var path: String { get }
    /// method use for post or get
    var method: HTTPMethod { get }
    /// parameter is a request parameter
    var parameters: RequestParams { get }
    /// header user for request header
    var headers: [String: String]? { get }
    /// datatype is JSON or Data formate
    var dataType: ResponseDataType { get }
    
    /// This function generate absolute path
    /// - Parameter basePath: base url
    /// - Returns: full path of the api
    func absolutePath(from basePath: String) -> String
}

/// This is APIData extension
extension APIData {
    /// This function generate absolute path
    /// - Parameter basePath: base url
    /// - Returns: full path of the api
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}
