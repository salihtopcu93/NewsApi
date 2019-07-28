//
//  DetailsModel.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation

struct DetailsModel {
    let source: [SourceModel]?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isAddedToReadingList = false

}

extension DetailsModel: Decodable {

        enum DetailsCodingKeys:String, CodingKey {
            case source = "source"
            case author = "author"
            case title = "title"
            case description = "description"
            case url = "url"
            case urlToImage = "urlToImage"
            case publishedAt = "publishedAt"
            case content = "content"
        }

        init(from decoder : Decoder) throws {
            let container = try decoder.container(keyedBy: DetailsCodingKeys.self)

            source = try? container.decode([SourceModel].self, forKey: .source)
            author = try? container.decode(String.self, forKey: .author)
            title = try? container.decode(String.self, forKey: .title)
            description = try? container.decode(String.self, forKey: .description)
            url = try? container.decode(String.self, forKey: .url)
            urlToImage = try? container.decode(String.self, forKey: .urlToImage)
            publishedAt = try? container.decode(String.self, forKey: .publishedAt)
            content = try? container.decode(String.self, forKey: .content)
        }

    var publishedDate: String {
        let isoDate = self.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from:isoDate!) else { return "" }
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH:mm:ss"
        return myDateFormatter.string(from: date)
    }

}
