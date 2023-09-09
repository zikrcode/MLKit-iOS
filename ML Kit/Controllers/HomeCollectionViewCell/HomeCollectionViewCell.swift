//
//  HomeCollectionViewCell.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 11/07/2023.
//

import UIKit

struct HomeItem {
    let image: UIImage?
    let title: String
    let description: String
    let segueIdentifier: String
}

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    static let reuseIdentifier = "HomeCollectionViewCell"
    static let cellHeight = 300.0
    
    private(set) var segueIdentifier: String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = AppConstants.DOUBLE_CORNER_RADIUS
    }
    
    func bind(item: HomeItem) {
        iconImageView.image = item.image
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        segueIdentifier = item.segueIdentifier
    }
}
