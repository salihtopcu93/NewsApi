//
//  SourceModel.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation

struct SourceModel: Equatable {
    let id:Bool?
    let name: String?
}

extension SourceModel: Decodable {
    enum SourceCodingKeys:String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SourceCodingKeys.self)

        id = try? container.decode(Bool.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
    }
}
