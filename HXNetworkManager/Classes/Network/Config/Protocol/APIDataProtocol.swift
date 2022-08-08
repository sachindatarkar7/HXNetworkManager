//
//  APIDataProtocol.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//

import Foundation

public protocol APIData {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var dataType: ResponseDataType { get }
    func absolutePath(from basePath: String) -> String
}

extension APIData {
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}
