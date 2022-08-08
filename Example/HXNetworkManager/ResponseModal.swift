//
//  ResponseModal.swift
//  HXNetworkManager_Example
//
//  Created by Sachin Datarkar on 08/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct ArticleResponseModel: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let title: String
    let descriptions: String?
}

