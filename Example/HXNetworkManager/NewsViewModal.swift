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
        let requestParameter = RequestParams(urlParameters: [Constant.shareInstance.country : "in", Constant.shareInstance.apiKey: Constant.shareInstance.apiKey_value], bodyParameters: nil)
        
        let apidata = ApiRequestData(path: EndPoint.topheadlines.rawValue, method: .get, parameters: requestParameter, dataType: .JSON)
        
        self.apiClient?.fetch(request: apidata, basePath: Constant.shareInstance.baseUrl, responseType: ArticleResponseModel.self, keyDecodingStrategy: .useDefaultKeys, completionHandler: { result in
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
