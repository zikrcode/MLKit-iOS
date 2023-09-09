//
//  AppConstants.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 11/07/2023.
//

import Foundation

class AppConstants {
    
    static let SINGLE_HALF_CORNER_RADIUS: CGFloat = 4
    static let SINGLE_CORNER_RADIUS: CGFloat = 8
    static let DOUBLE_CORNER_RADIUS: CGFloat = 16
    
    static let IMAGE_LOADING_TIME = 0.1
    
    static let BARCODE_SCANNING_SEGUE_ID = "BarcodeScanningSegue"
    static let TEXT_RECOGNITION_SEGUE_ID = "TextRecognitionSegue"
    static let IMAGE_LABELING_SEGUE_ID = "ImageLabelingSegue"
    static let LANGUAGE_IDENTIFICATION_SEGUE_ID = "LanguageIdentificationSegue"
    static let TRANSLATION_SEQUE_ID = "TranslationSegue"
    static let RESULT_SEGUE_ID = "ResultSegue"
    
    static let RESULT_SOURCE_KEY = "ResultSource"
    static let RESULT_IMAGE_KEY = "ResultImage"
    static let RESULT_TEXT_KEY = "ResultText"
    
    //BarcodeScanningViewController
    static let BARCODE_SCANNING_SOURCE = "BarcodeScanning"
    static let DISPLAY_VALUE_KEY = "DisplayValue"
    static let RAW_VALUE_KEY = "RawValue"
    static let FRAME_KEY = "FrameValue"
    
    //TextRecognitionViewController
    static let TEXT_RECOGNITION_SOURCE = "TextRecognition"
    static let TEXT_VALUE_KEY = "TextValue"
    
    //ImageLabelingViewController
    static let IMAGE_LABELING_SOURCE = "ImageLabeling"
    static let LABEL_TEXT_KEY = "LabelText"
    static let CONFIDENCE_KEY = "Confidence"
    static let INDEX_KEY = "Index"
    
    //LanguageIdentificationViewController
    static let POSSIBLE_LANGUAGES_FORMAT = "(%@, %.2f)"
    
    //TranslationViewController
    static let PICKER_NUMBER_OF_COMPONENT = 1
    static let INPUT_PICKER_DEFAULT_INDEX = 1
    static let OUTPUT_PICKER_DEFAULT_INDEX = 3
    
    private init() {}
}
