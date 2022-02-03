//
//  String+Localization.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 31/01/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
