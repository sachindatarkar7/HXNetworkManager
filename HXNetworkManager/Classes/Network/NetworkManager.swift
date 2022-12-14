//
//  NetworkManager.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//


import Foundation

/// NetworkManager implement network manager protocol
public class NetworkManager: NetworkManagerProtocol {
    
    public static let shared = NetworkManager()
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    
    private init() {
    }
    
    /// This function used for call api request
    /// - Parameters:
    ///   - request: request is api request
    ///   - basePath: basePath is a base url
    ///   - completion: return completion handle with data response and error
    public func startRequest(request: APIData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        do {
            let urlRequest = try self.createURLRequest(apiData: request, basePath: basePath)
            
            task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            task?.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
}

private extension NetworkManager {
    
    /// This function use for creating request
    /// - Parameters:
    ///   - apiData: apiData is request data
    ///   - basePath: basePath base url
    /// - Returns: return URLRequest
    private func createURLRequest(apiData: APIData, basePath: String) throws -> URLRequest {
        do {
            if let url = URL(string: apiData.absolutePath(from: basePath))  {
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = apiData.method.rawValue
                self.addRequestHeaders(request: &urlRequest, requestHeaders: apiData.headers)
                try self.encode(request: &urlRequest, parameters: apiData.parameters)
                
                return urlRequest
            } else {
                throw NetworkError.malformedURL
            }
        } catch {
            throw error
        }
    }
    
    /// This function use for add header in request
    /// - Parameters:
    ///   - request: request is URL request
    ///   - requestHeaders: requestHeaders is header object
    private func addRequestHeaders(request: inout URLRequest, requestHeaders: [String: String]?){
        guard let headers = requestHeaders else{
            return
        }
        for (key, value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /// This function use for the encode request
    /// - Parameters:
    ///   - request: request is URL request
    ///   - parameters: parameters is a request parameter
    private func encode(request: inout URLRequest, parameters: RequestParams?) throws{
        
        guard let url: URL = request.url else {
            throw NetworkError.malformedURL
        }
        guard let parameters = parameters else{
            return
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let urlParams = parameters.urlParameters, !urlParams.isEmpty{
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in urlParams{
                let queryItem = URLQueryItem(name: key, value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
        
        if let bodyParams = parameters.bodyParameters, !bodyParams.isEmpty{
            do{
                switch parameters.contentType{
                case .json:
                    try self.encodeJSON(request: &request, parameters: bodyParams)
                }
            }catch{
                throw NetworkError.parameterEncodingFailed
            }
        }
    }
    
    /// This function use for encode json
    /// - Parameters:
    ///   - request: request is URL request
    ///   - parameters: parameters is a request parameter
    private func encodeJSON(request: inout URLRequest, parameters: [String: Any]) throws{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            request.setValue(HeaderContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderKeys.contentType.rawValue)
            
        }catch{
            throw NetworkError.parameterEncodingFailed
        }
    }
}
