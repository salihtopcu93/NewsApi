//
//  Details.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation

struct Details {

    let status : String?
    var articles : [DetailsModel]?
}

extension Details : Decodable {

    enum  DetailsCodingKeys : String, CodingKey {
        case status = "status"
        case articles = "articles"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailsCodingKeys.self)

        status = try? container.decode(String.self, forKey: .status)
        articles = try? container.decode([DetailsModel].self, forKey: .articles)
    }

}
