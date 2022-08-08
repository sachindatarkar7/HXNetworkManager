//
//  NewsViewModal.swift
//  HXNetworkManager_Example
//
//  Created by Sachin Datarkar on 08/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import HXNetworkManager

protocol NewsViewModalProtocol {
    func updateResponse(article: [Articles])
    func showError(message: String)
       
}

class NewsViewModal {
    let apiClient: APIClientProtocol?
    let delegate: NewsViewModalProtocol?
    
    init(_ apiclient:APIClientProtocol, _ delegate: NewsViewModalProtocol) {
        self.apiClient = apiclient
        self.delegate = delegate
    }
    
    func fetchNewsApi()  {
        let requestParameter = RequestParams(urlParameters: ["country" : "in", "apiKey": "8c1a6e5f68894e818ff42f7f2f4187ac"], bodyParameters: nil)
        
        let apidata = ApiRequestData(path: "top-headlines", method: .get, parameters: requestParameter, dataType: .JSON)
        
        self.apiClient?.fetch(request: apidata, basePath: "https://newsapi.org/v2/", responseType: ArticleResponseModel.self, keyDecodingStrategy: .useDefaultKeys, completionHandler: { result in
            switch result {
            case .success(let artcleObj):
                self.delegate?.updateResponse(article: artcleObj.articles)
                return
            case .failure(let error):
                self.delegate?.showError(message: error.localizedDescription)
                return
            }
        })
    }
}
