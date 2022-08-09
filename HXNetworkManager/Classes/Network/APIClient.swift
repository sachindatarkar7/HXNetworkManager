//
//  APIClient.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//

import Foundation

/// ApiClient class use for all network related call
public class APIClient: APIClientProtocol {
    
    /// This instance for network manager protocol
    private let authManager: NetworkManagerProtocol
    
    /// Apiclient class initialisation
    /// - Parameter authorizationManager: authorizationManager is a network manager instance
   public init(authorizationManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.authManager = authorizationManager
    }
    
    
    /// This function use for the generic api call
    /// - Parameters:
    ///   - request: make a request using APIData protocol
    ///   - basePath: basePath is base url
    ///   - responseType: responseType is pass response modal
    ///   - keyDecodingStrategy: the strategy to use for automatically changing the value of keys before decoding.
    ///   - completionHandler: pass completion handler with generic data and error
    public func fetch<T: Codable>(request: APIData, basePath: String, responseType:T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        self.authManager.startRequest(request: request, basePath: basePath) { (data, response, error) in
            
            if let _ = error{
                let errorType = NetworkError.failed
                completionHandler(.failure(errorType))
                return
            }
            
            guard let responseData = response as? HTTPURLResponse,
                let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    completionHandler(.failure(errorType))
                    return
            }
            
            let responseStatus = self.isValidResposne(response: responseData)
            switch responseStatus {
            case .success:
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
                do {
                    let apiResponseModel = try jsonDecoder.decode(T.self, from: receivedData)
                    completionHandler(.success(apiResponseModel))
                } catch {
                    completionHandler(.failure(NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// This function use for call normal api
    /// - Parameters:
    ///   - request: make a request using APIData protocol
    ///   - basePath:basePath is base url
    ///   - success: getting success response
    ///   - failure: getting failer response
    public func fetch(request: APIData, basePath: String, success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {
        self.authManager.startRequest(request: request, basePath: basePath) { (data, response, error) in
            if let _ = error{
                let errorType = NetworkError.other(message: error?.localizedDescription)
                failure(data, response, errorType)
                return
            }
            
            guard let responseData = response as? HTTPURLResponse,
                let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    failure(data, response, errorType)
                    return
            }
            
            let responseStatus = self.isValidResposne(response: responseData)
            switch responseStatus {
            case .success:
                success(receivedData, response)
            case .failure(let error):
                failure(data, response, error)
            }
        }
    }
    
    /// This function check valid response
    /// - Parameter response: response is a httpurlresponse
    /// - Returns: return generic response
    func isValidResposne(response: HTTPURLResponse) -> Result<String, NetworkError>{
        switch response.statusCode{
        case 200...299:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
}
