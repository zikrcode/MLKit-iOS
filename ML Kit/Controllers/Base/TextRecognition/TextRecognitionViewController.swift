//
//  TextRecognitionViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 17/07/2023.
//

import UIKit
import MLKit
import MLKitTextRecognition

class TextRecognitionViewController: BaseViewController {
    
    @IBOutlet private weak var detectButton: UIButton!
    
    private var resultImage: UIImage? = nil
    private var resultText: [Int: [String: String]] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.RESULT_SEGUE_ID {
            if let resultVC = segue.destination as? ResultViewController {
                let data: [String: Any?] = [
                    AppConstants.RESULT_SOURCE_KEY: AppConstants.TEXT_RECOGNITION_SOURCE,
                    AppConstants.RESULT_IMAGE_KEY: resultImage,
                    AppConstants.RESULT_TEXT_KEY: resultText
                ]
                resultVC.setReceivedData(data)
            }
        }
    }
    
    override func setupViews() {
        self.title = "text_rec_title".localized
        detectButton.setTitle("detect_texts".localized)
    }

    @IBAction private func detectButtonClicked(_ sender: UIButton) {
        detectTexts(image: mainImageView.image)
    }
    
    private func detectTexts(image: UIImage?) {
        guard let image = image else { return }
        
        let latinOptions = TextRecognizerOptions()
        let latinTextRecognizer = TextRecognizer.textRecognizer(options: latinOptions)
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        latinTextRecognizer.process(visionImage) { [weak self] result, error in
            guard let self = self else { return }
            
            guard error == nil, let result = result else {
                let title = "text_rec_error_title".localized
                let message = "text_rec_error_message".localized
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                
                self.showAlert(error: errorText, title: title, message: message)
                return
            }
            
            self.resultImage = image
            self.resultText.removeAll()
            
            for i in result.blocks.indices {
                let block = result.blocks[i]
                let result = [
                    AppConstants.TEXT_VALUE_KEY: block.text.map { String($0) }.joined(),
                    AppConstants.FRAME_KEY: String(describing: block.frame)
                ]
                self.resultText[i] = result
                self.resultImage = self.resultImage?.applyOverlay(color: .green, with: block.frame)
            }
            
            self.navigateToResultVC()
        }
    }
}
