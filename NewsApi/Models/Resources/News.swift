//
//  News.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation

struct News {

    let status : String?
    let sources : [SourcesModel]
}

extension News : Decodable {

    enum  NewsCodingKeys : String, CodingKey {
        case status = "status"
        case sources = "sources"
}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKeys.self)

        status = try? container.decode(String.self, forKey: .status)
        sources = try! container.decode([SourcesModel].self, forKey: .sources)
    }

}
