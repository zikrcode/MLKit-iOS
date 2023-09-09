//
//  ResultFooterTableViewCell.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 13/07/2023.
//

import UIKit

protocol ResultFooterTableViewCellDelegate: AnyObject {
    func onExitButtonClicked()
}

class ResultFooterTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet private weak var exitButton: UIButton!
    
    static let reuseIdentifier = "ResultFooterTableViewCell"
    static let height = 70.0
    
    weak var delegate: ResultFooterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews() {
        exitButton.titleLabel?.text = "exit".localized
    }
    
    @IBAction private func exitButtonClicked(_ sender: UIButton) {
        delegate?.onExitButtonClicked()
    }
}
