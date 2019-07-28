//
//  ArticlesModel.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation

struct SourcesModel: Decodable {

    let id: String?
    let name: String?
    let description: String?
    let url: URL?
    let category: String?
    let language: String?
    let country:String?

}
