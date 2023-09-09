//
//  ResultHeaderTableViewCell.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 13/07/2023.
//

import UIKit

class ResultHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet private weak var resultImageView: UIImageView!
    
    static let reuseIdentifier = "ResultHeaderTableViewCell"
    static let height = 300.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        resultImageView.layer.cornerRadius = AppConstants.DOUBLE_CORNER_RADIUS
    }
    
    func bind(image: UIImage?) {
        guard let image = image else { return }
        resultImageView.image = image
    }
}
