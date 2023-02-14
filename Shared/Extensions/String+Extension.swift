//
//  String+Extension.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
