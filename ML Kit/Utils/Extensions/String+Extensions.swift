//
//  String+Extensions.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 14/07/2023.
//

import UIKit

extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
