//
//  LanguageIdentificationViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 18/07/2023.
//

import UIKit
import MLKit

class LanguageIdentificationViewController: UIViewController {

    @IBOutlet private weak var mainTextView: UITextView!
    @IBOutlet private weak var identifyLanguageButtonItem: UIBarButtonItem!
    @IBOutlet private weak var possibleLanguageButtonItem: UIBarButtonItem!
    @IBOutlet private weak var resultTextView: UITextView!
    
    private var languageId: LanguageIdentification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        self.title = "language_iden_title".localized
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
        
        mainTextView.text = "type_here".localized
        identifyLanguageButtonItem.title = "identify_language".localized
        possibleLanguageButtonItem.title = "possible_languages".localized
        
        languageId = LanguageIdentification.languageIdentification()
    }
    
    @IBAction private func identifyLanguageButtonClicked(_ sender: UIBarButtonItem) {
        identifyLanguage(text: mainTextView.text)
    }
    
    @IBAction private func possibleLanguageButtonClicked(_ sender: UIBarButtonItem) {
        possibleLanguages(text: mainTextView.text)
    }
    
    private func identifyLanguage(text: String) {
        languageId.identifyLanguage(for: text) { [weak self] languageTag, error in
            guard let self = self else { return }
            
            guard error == nil, let languageTag = languageTag else {
                let title = "language_iden_error_title".localized
                let message = "language_iden_error_message".localized
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                
                self.showAlert(error: errorText, title: title, message: message)
                return
            }
            
            self.resultTextView.text = "\("identified_language".localized) \(self.languageDisplayName(for: languageTag))"
        }
    }
    
    private func possibleLanguages(text: String) {
        languageId.identifyPossibleLanguages(for: text) { [weak self] identifiedLanguages, error in
            guard let self = self else { return }
            
            guard error == nil, let identifiedLanguages = identifiedLanguages else {
                let title = "language_iden_error_title".localized
                let message = "language_iden_error_message".localized
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                
                self.showAlert(error: errorText, title: title, message: message)
                return
            }
            
            let languages =  identifiedLanguages.map {
                String(format: AppConstants.POSSIBLE_LANGUAGES_FORMAT, self.languageDisplayName(for: $0.languageTag), $0.confidence)
            }.joined(separator: "\n")
            self.resultTextView.text = "\("possible_languages_n".localized) \(languages)"
        }
    }
    
    private func languageDisplayName(for languageTag: String) -> String {
        let unknown = "undetermined_language".localized
        
        if languageTag == IdentifiedLanguage.undetermined {
            return unknown
        } else {
            return Locale.current.localizedString(forLanguageCode: languageTag) ?? unknown
        }
    }
}
