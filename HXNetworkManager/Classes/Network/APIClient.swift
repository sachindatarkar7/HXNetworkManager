//
//  APIClient.swift
//  HXNetworkManager
//
//  Created by Sachin Datarkar on 05/08/22.
//

import Foundation

public class APIClient: APIClientProtocol {
    private let authManager: NetworkManagerProtocol
    
   public init(authorizationManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.authManager = authorizationManager
    }
    
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
