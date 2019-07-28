//
//  ResourcesViewModell.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation
import UIKit

protocol NewsViewDelegate: class {
    func updatedList()
}

class ResourcesViewModel {
    var result : News?
    var delegate: NewsViewDelegate?

    func getNews() {
        setLoading(true)

        provider.request(.search) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let value):
                let data = value.data
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    self.result = result
                    print(result)
                    self.delegate?.updatedList()
                    print(result.sources)
                } catch let error {
                    print(error)
                }
                self.setLoading(false)
            }
        }
    }

    func setLoading (_  isLoading : Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }

}
