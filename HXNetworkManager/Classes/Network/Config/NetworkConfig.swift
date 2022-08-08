//
//  NetworkConfig.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

public enum ResponseDataType {
    case Data
    case JSON
}

public enum Encoding: String {
    case URL
    case JSON
}

public enum HeaderContentType: String {
    case json = "application/json"
}

public enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case cookie = "Cookie"
}


public struct RequestParams {
    public let urlParameters: [String: String]?
    public let bodyParameters: [String: Any]?
    public let contentType: HeaderContentType
    
   public init(urlParameters: [String: String]?, bodyParameters: [String: Any]?, contentType: HeaderContentType = .json) {
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.contentType = contentType
    }
}
