//
//  HomeViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 11/07/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var homeCollectionView: UICollectionView!
    
    private var homeCollectionViewDataSource: [HomeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configureCollectionView() {
        homeCollectionView.layer.cornerRadius = AppConstants.DOUBLE_CORNER_RADIUS
        homeCollectionView.clipsToBounds = true
        
        let nib = UINib(nibName: HomeCollectionViewCell.reuseIdentifier, bundle: nil)
        homeCollectionView.register(nib, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        populateDataSource()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    private func populateDataSource() {
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "BarcodeScanning".image,
                title: "barcode_title".localized,
                description: "barcode_desc".localized,
                segueIdentifier: AppConstants.BARCODE_SCANNING_SEGUE_ID
            )
        )
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "TextRecognition".image,
                title: "text_rec_title".localized,
                description: "text_rec_desc".localized,
                segueIdentifier: AppConstants.TEXT_RECOGNITION_SEGUE_ID
            )
        )
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "ImageLabeling".image,
                title: "image_lab_title".localized,
                description: "image_lab_desc".localized,
                segueIdentifier: AppConstants.IMAGE_LABELING_SEGUE_ID
            )
        )
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "LanguageIdentification".image,
                title: "language_iden_title".localized,
                description: "language_iden_desc".localized,
                segueIdentifier: AppConstants.LANGUAGE_IDENTIFICATION_SEGUE_ID
            )
        )
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "Translation".image,
                title: "translation_title".localized,
                description: "translation_desc".localized,
                segueIdentifier: AppConstants.TRANSLATION_SEQUE_ID
            )
        )
        homeCollectionViewDataSource.append(
            HomeItem(
                image: "HandwrittenTextRecognition".image,
                title: "handwritten_rec_title".localized,
                description: "handwritten_rec_desc".localized,
                segueIdentifier: AppConstants.BARCODE_SCANNING_SEGUE_ID
            )
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeCollectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        let item = homeCollectionViewDataSource[indexPath.item]
                
        cell.bind(item: item)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        
        guard let segueIdentifier = cell.segueIdentifier else { return }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: HomeCollectionViewCell.cellHeight)
    }
}
