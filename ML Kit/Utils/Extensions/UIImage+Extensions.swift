//
//  UIImage+Extensions.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 14/07/2023.
//

import UIKit

extension UIImage {
    func applyOverlay(color: UIColor, with frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        draw(at: CGPoint.zero)

        context.setFillColor(color.withAlphaComponent(0.5).cgColor)
        context.fill(frame)

        let updatedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return updatedImage
    }
}
