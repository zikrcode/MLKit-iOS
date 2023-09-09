//
//  BaseViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 17/07/2023.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageLoadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction private func selectImageButtonClicked(_ sender: UIBarButtonItem) {
        showImageLoadingActivityIndicator(show: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.IMAGE_LOADING_TIME) {
            self.selectImage()
        }
    }
    
    @IBAction private func openCameraButtonClicked(_ sender: UIBarButtonItem) {
        showImageLoadingActivityIndicator(show: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.IMAGE_LOADING_TIME) {
            self.openCamera()
        }
    }
    
    private func showImageLoadingActivityIndicator(show: Bool) {
        imageLoadingActivityIndicator.isHidden = !show
    }
    
    func setupViews() {
        fatalError("Subclasses must override `setupViews()`")
    }

    func navigateToResultVC() {
        performSegue(withIdentifier: AppConstants.RESULT_SEGUE_ID, sender: self)
    }
}

extension BaseViewController: UIImagePickerControllerDelegate {
    
    private func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true) { [weak self] in
            self?.showImageLoadingActivityIndicator(show: false)
        }
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true) { [weak self] in
            self?.showImageLoadingActivityIndicator(show: false)
        }
    }
}

extension BaseViewController: UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else { return }

        mainImageView.image = image
        dismiss(animated: true)
    }
}
