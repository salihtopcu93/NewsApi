//
//  ResourcesViewController.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = ResourcesViewModel()
    var news: News?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNews()
        viewModel.delegate = self
    }
}

extension ResourcesViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result?.sources.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResourcesTableViewCell
        guard let source = viewModel.result?.sources[indexPath.row] else { return UITableViewCell() }

        cell.configure(source: source)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailViewController.result = viewModel.result?.sources[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ResourcesViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ResourcesViewController : NewsViewDelegate {
    func updatedList() {
        tableView.reloadData()
    }
}
