//
//  ApiRequestData.swift
//  HXNetworkManager_Example
//
//  Created by Sachin Datarkar on 08/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import HXNetworkManager

struct ApiRequestData: APIData {

    var path: String
    
    var method: HTTPMethod
    
    var parameters: RequestParams
    
    var headers: [String : String]?
    
    var dataType: ResponseDataType
    
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
    
}

