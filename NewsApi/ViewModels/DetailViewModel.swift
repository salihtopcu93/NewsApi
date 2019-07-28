//
//  DetailViewModel.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewDelegate: class {
    func updatedList(result: Details?)
}

class DetailViewModel {
    var result : Details?
    var delegate: DetailViewDelegate?
    var filteredResult: Details?
    var id: String?
    var timer: Timer = Timer()

    init(id: String) {
        self.id = id
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(getDetails), userInfo: nil, repeats: true)
        timer.fire()
    }

    func invalidateTimer() {
        timer.invalidate()
    }

    @objc func getDetails() {
        setLoading(true)

        provider.request(.detail(id: self.id!)) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let value):
                let data = value.data
                do {
                    let result = try JSONDecoder().decode(Details.self, from: data)
                    self.result = result
                    print(result)
                    self.handleReading()

                } catch let error {
                    print(error)
                }
                self.setLoading(false)
            }
        }
    }

    func search(with key: String) {
        if key.isEmpty {
            self.delegate?.updatedList(result: result)
            return
        }

        filteredResult = result

        let rooms = filteredResult?.articles!.filter {
            $0.title?.range(of: key, options: .caseInsensitive) != nil

        }

        filteredResult?.articles = rooms!
        self.delegate?.updatedList(result: filteredResult)

    }

    func addToReadingList(publishedDate: String) {
        var readingListArray = UserDefaults.standard.array(forKey: "readingList") ?? [String]()

        if let readingListStringArray = readingListArray as? [String] {
            if let index = readingListStringArray.index(of: publishedDate) {
                readingListArray.remove(at: index)
            } else {
                readingListArray.append(publishedDate)
            }
        }

        UserDefaults.standard.set(readingListArray, forKey: "readingList")
        UserDefaults.standard.synchronize()

    }

    func handleReading() {
        guard let readingListArray: [String] = UserDefaults.standard.array(forKey: "readingList") as? [String] else {
            self.delegate?.updatedList(result: result)
            return
        }
        guard var result = result?.articles else { return }

        for (index, item) in result.enumerated() {
            if readingListArray.contains(item.publishedDate) {
                result[index].isAddedToReadingList = true
            }
        }

        self.result?.articles = result
        self.delegate?.updatedList(result: self.result)

    }

    func setLoading (_  isLoading : Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }

}
