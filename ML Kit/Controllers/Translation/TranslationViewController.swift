//
//  TranslationViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 19/07/2023.
//

import UIKit
import MLKitTranslate

class TranslationViewController: UIViewController {
    
    @IBOutlet weak private var inputTextView: UITextView!
    @IBOutlet weak private var outputTextView: UITextView!
    @IBOutlet weak private var inputPicker: UIPickerView!
    @IBOutlet weak private var outputPicker: UIPickerView!
    
    private let languages = [
        "ar".localized,
        "en".localized,
        "de".localized,
        "pl".localized,
        "ru".localized,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.title = "translation_title".localized
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
        
        inputTextView.text = "type_here".localized
        inputTextView.delegate = self
        
        inputPicker.dataSource = self
        inputPicker.delegate = self
        outputPicker.dataSource = self
        outputPicker.delegate = self
        
        inputPicker.selectRow(AppConstants.INPUT_PICKER_DEFAULT_INDEX, inComponent: 0, animated: false)
        outputPicker.selectRow(AppConstants.OUTPUT_PICKER_DEFAULT_INDEX, inComponent: 0, animated: false)
    }
    
    @IBAction private func swapLanguageButtonClicked(_ sender: UIButton) {
        let inputSelectedRow = inputPicker.selectedRow(inComponent: 0)
        let outputSelectedRow = outputPicker.selectedRow(inComponent: 0)
        
        inputPicker.selectRow(outputSelectedRow, inComponent: 0, animated: false)
        outputPicker.selectRow(inputSelectedRow, inComponent: 0, animated: false)
        
        let inputText = inputTextView.text
        let outputText = outputTextView.text
        
        if (!(inputText?.isEmpty ?? true) && !(outputText?.isEmpty ?? true) ) {
            inputTextView.text = outputText
            outputTextView.text = inputText
        }
    }
    
    private func translateText() {
        let sourceLanguage = getSelectedLanguageFrom(picker: inputPicker)
        let targetLanguage = getSelectedLanguageFrom(picker: outputPicker)
        
        let options = TranslatorOptions(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
        let translator = Translator.translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        
        translator.downloadModelIfNeeded(with: conditions) { [weak self] error in
            guard let self = self else { return }
            
            guard error == nil else {
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                self.showError(errorText: errorText)
                return
            }
            
            self.performTranslation(with: translator)
        }
    }
    
    private func performTranslation(with translator: Translator) {
        translator.translate(inputTextView.text) { [weak self] outputText, error in
            guard let self = self else { return }
            
            guard error == nil else {
                let errorText = error?.localizedDescription ?? "something_went_wrong".localized
                self.showError(errorText: errorText)
                return
            }
            
            self.outputTextView.text = outputText
        }
    }
    
    private func getSelectedLanguageFrom(picker: UIPickerView) -> TranslateLanguage {
        let index = picker.selectedRow(inComponent: 0)
        
        var selectedLanguage: TranslateLanguage {
            switch languages[index] {
            case "ar".localized: return TranslateLanguage.arabic
            case "en".localized: return TranslateLanguage.english
            case "de".localized: return TranslateLanguage.german
            case "pl".localized: return TranslateLanguage.polish
            case "ru".localized: return TranslateLanguage.russian
            default: return TranslateLanguage.english
            }
        }
        
        return selectedLanguage
    }
    
    private func showError(errorText: String) {
        let title = "translation_error_title".localized
        let message = "translation_error_message".localized
        
        showAlert(error: errorText, title: title, message: message)
    }
}

extension TranslationViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        translateText()
    }
}

extension TranslationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return AppConstants.PICKER_NUMBER_OF_COMPONENT
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
}

extension TranslationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        translateText()
    }
}
