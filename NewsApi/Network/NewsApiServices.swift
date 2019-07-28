//
//  NewsApiServices.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation
import Moya

enum NewsApiService {
    case search
    case detail(id: String)
}

let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
let provider = MoyaProvider<NewsApiService>(plugins: pluginsArray)

extension NewsApiService: TargetType {

    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }

    var path: String {
        switch self {
        case .detail:
            return "top-headlines"
        case .search:
            return "sources"
        }
    }

    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        case .detail:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var params = [String: Any]()
        params["apiKey"] = "39f9562a5a1243e4b393d7c8a76d3eb6"

        switch self {
        case .detail(id: let id ):
            params["sources"] = id
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .search:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }

}
