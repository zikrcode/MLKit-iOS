//
//  BarcodeScanningViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 11/07/2023.
//

import UIKit
import MLKit

class BarcodeScanningViewController: BaseViewController {

    @IBOutlet private weak var detectButton: UIButton!
    
    private var resultImage: UIImage? = nil
    private var resultText: [Int: [String: String]] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.RESULT_SEGUE_ID {
            if let resultVC = segue.destination as? ResultViewController {
                let data: [String: Any?] = [
                    AppConstants.RESULT_SOURCE_KEY: AppConstants.BARCODE_SCANNING_SOURCE,
                    AppConstants.RESULT_IMAGE_KEY: resultImage,
                    AppConstants.RESULT_TEXT_KEY: resultText
                ]
                resultVC.setReceivedData(data)
            }
        }
    }
    
    override func setupViews() {
        self.title = "barcode_title".localized
        detectButton.setTitle("detect_barcodes".localized)
    }

    @IBAction private func detectButtonClicked(_ sender: UIButton) {
        detectBarcodes(image: mainImageView.image)
    }
    
    private func detectBarcodes(image: UIImage?) {
        guard let image = image else { return }
        
        let format = BarcodeFormat.all
        let barcodeOptions = BarcodeScannerOptions(formats: format)
        
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        barcodeScanner.process(visionImage) { [weak self] barcodes, error in
            guard let self = self else { return }
            
            guard error == nil, let barcodes = barcodes, !barcodes.isEmpty else {
                let title = "barcode_scan_error_title".localized
                let message = "barcode_scan_error_message".localized
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                
                self.showAlert(error: errorText, title: title, message: message)
                return
            }
            
            self.resultImage = image
            self.resultText.removeAll()
        
            for i in barcodes.indices {
                let barcode = barcodes[i]
                let result = [
                    AppConstants.DISPLAY_VALUE_KEY: barcode.displayValue ?? "",
                    AppConstants.RAW_VALUE_KEY: barcode.rawValue ?? "",
                    AppConstants.FRAME_KEY: String(describing: barcode.frame)
                ]
                self.resultText[i] = result
                self.resultImage = self.resultImage?.applyOverlay(color: .green, with: barcode.frame)
            }
            
            self.navigateToResultVC()
        }
    }
}
