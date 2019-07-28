//
//  ResourcesTableViewCell.swift
//  NewsApi
//
//  Created by Salih Topcu on 26.07.2019.
//  Copyright © 2019 Salih Topcu. All rights reserved.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(source: SourcesModel) {

        let title = source.name
        let subTitle = source.description

        titleLabel.text = title
        descriptionLabel.text = subTitle
    }

}
