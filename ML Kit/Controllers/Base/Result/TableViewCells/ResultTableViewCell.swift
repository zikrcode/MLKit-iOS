//
//  ResultTableViewCell.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 13/07/2023.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var firstStackView: UIStackView!
    @IBOutlet private weak var secondStackView: UIStackView!
    @IBOutlet private weak var thirdStackView: UIStackView!

    @IBOutlet private weak var title1Label: UILabel!
    @IBOutlet private weak var title2Label: UILabel!
    @IBOutlet private weak var title3Label: UILabel!
    
    @IBOutlet private weak var description1Label: UILabel!
    @IBOutlet private weak var description2Label: UILabel!
    @IBOutlet private weak var description3Label: UILabel!
    
    static let reuseIdentifier = "ResultTableViewCell"

    func bind(source: String, data: [String: String]?) {
        switch source {
        case AppConstants.BARCODE_SCANNING_SOURCE:
            setupViewsForBarcodeScanning(data)
        case AppConstants.TEXT_RECOGNITION_SOURCE:
            setupViewsForTextRecognition(data)
        case AppConstants.IMAGE_LABELING_SOURCE:
            setupViewsForImageLabeling(data)
        default: break
        }
    }
    
    private func setupViewsForBarcodeScanning(_ data: [String: String]?) {
        title1Label.text = "rc_display_value".localized
        title2Label.text = "rc_raw_value".localized
        title3Label.text = "rc_frame".localized
        
        description1Label.text = data?[AppConstants.DISPLAY_VALUE_KEY] as? String
        description2Label.text = data?[AppConstants.RAW_VALUE_KEY] as? String
        description3Label.text = data?[AppConstants.FRAME_KEY] as? String
    }
    
    private func setupViewsForTextRecognition(_ data: [String: String]?) {
        title1Label.text = "rc_text_value".localized
        title2Label.text = "rc_frame".localized
        
        description1Label.text = data?[AppConstants.TEXT_VALUE_KEY] as? String
        description2Label.text = data?[AppConstants.FRAME_KEY] as? String
        
        thirdStackView.isHidden = true
    }
    
    private func setupViewsForImageLabeling(_ data: [String: String]?) {
        title1Label.text = "rc_label_text".localized
        title2Label.text = "rc_confidence".localized
        title3Label.text = "rc_index".localized
        
        description1Label.text = data?[AppConstants.LABEL_TEXT_KEY] as? String
        description2Label.text = data?[AppConstants.CONFIDENCE_KEY] as? String
        description3Label.text = data?[AppConstants.INDEX_KEY] as? String
    }
}
