//
//  UIButton+Extensions.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 18/07/2023.
//

import UIKit

extension UIButton {
    func setTitle(_ text: String) {
        if let font = titleLabel?.font {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
            ]
            let attributedTitle = NSAttributedString(string: text, attributes: attributes)
            
            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
