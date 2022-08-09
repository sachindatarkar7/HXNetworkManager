//
//  NetworkConfig.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

/// Network config creation

/// HTTP Method type
public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

/// Response data Type
public enum ResponseDataType {
    case Data
    case JSON
}

/// Response encoding formate
public enum Encoding: String {
    case URL
    case JSON
}

/// Request header content type
public enum HeaderContentType: String {
    case json = "application/json"
}

/// HTTP Header Keys
public enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case cookie = "Cookie"
}

/// This struct for request parameter creation
public struct RequestParams {
    /// Request parameter
    public let urlParameters: [String: String]?
    /// Body parameter
    public let bodyParameters: [String: Any]?
    /// Header content type
    public let contentType: HeaderContentType
    
    /// Init for request parameter
    /// - Parameters:
    ///   - urlParameters: urlParameters is a request parameter
    ///   - bodyParameters: bodyParameters is body parameter
    ///   - contentType: contentType is a header content type
   public init(urlParameters: [String: String]?, bodyParameters: [String: Any]?, contentType: HeaderContentType = .json) {
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.contentType = contentType
    }
}
