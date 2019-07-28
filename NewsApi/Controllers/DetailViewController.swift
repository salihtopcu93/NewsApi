//
//  DetailViewController.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: DetailViewModel!
    var result: SourcesModel!
    var searchData = [String]()
    var searching = false
    var detailResult: Details?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupViewModel()
        setTitle()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.invalidateTimer()
    }

    func setTitle() {
        navigationItem.title = result.name
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupViewModel() {
        viewModel = DetailViewModel(id: result.id ?? "")
        viewModel.delegate = self
    }
}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailResult?.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        cell.delegate = self

        guard let article = detailResult?.articles?[indexPath.row] else { return UITableViewCell() }

        cell.configure(details: article)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailResult = detailResult?.articles?[indexPath.row].url else {return}
        guard let url = URL(string: (detailResult)) else { return }
        UIApplication.shared.openURL(url)
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        viewModel.search(with: "")
    }

}

extension DetailViewController: DetailViewDelegate {

    func updatedList(result: Details?) {
        guard let result = result else { return }
        self.detailResult = result
        tableView.reloadData()
    }
}

extension DetailViewController: DetailTableViewCellProtocol {
    func addedToReadingList(details: DetailsModel) {

        guard let articles = self.detailResult?.articles! else { return }

        if let index = articles.firstIndex(where: {$0.publishedDate == details.publishedDate}) {
            self.detailResult?.articles![index] = details
        }

        viewModel.addToReadingList(publishedDate: details.publishedDate)
    }

}
