//
//  ImageLabelingViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 18/07/2023.
//

import UIKit
import MLKit
import MLKitImageLabeling

class ImageLabelingViewController: BaseViewController {
    
    @IBOutlet private weak var detectButton: UIButton!
    
    private var resultText: [Int: [String: String]] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.RESULT_SEGUE_ID {
            if let resultVC = segue.destination as? ResultViewController {
                let data: [String: Any?] = [
                    AppConstants.RESULT_SOURCE_KEY: AppConstants.IMAGE_LABELING_SOURCE,
                    AppConstants.RESULT_IMAGE_KEY: mainImageView.image,
                    AppConstants.RESULT_TEXT_KEY: resultText
                ]
                resultVC.setReceivedData(data)
            }
        }
    }
    
    override func setupViews() {
        self.title = "image_lab_title".localized
        detectButton.setTitle("detect_image_labels".localized)
    }

    @IBAction private func detectButtonClicked(_ sender: UIButton) {
        detectImageLabels(image: mainImageView.image)
    }
    
    private func detectImageLabels(image: UIImage?) {
        guard let image = image else { return }
        
        let options = ImageLabelerOptions()
        let labeler = ImageLabeler.imageLabeler(options: options)
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        labeler.process(visionImage) { [weak self] labels, error in
            guard let self = self else { return }
            
            guard error == nil, let labels = labels else {
                let title = "image_labeling_error_title".localized
                let message = "image_labeling_error_message".localized
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                
                self.showAlert(error: errorText, title: title, message: message)
                return
            }
            
            self.resultText.removeAll()
            
            for i in labels.indices {
                let label = labels[i]
                let result = [
                    AppConstants.LABEL_TEXT_KEY: label.text,
                    AppConstants.CONFIDENCE_KEY: String(label.confidence),
                    AppConstants.INDEX_KEY: String(label.index)
                ]
                self.resultText[i] = result
            }
            
            navigateToResultVC()
        }
    }
}
