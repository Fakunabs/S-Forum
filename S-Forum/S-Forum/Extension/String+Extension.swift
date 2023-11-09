//
//  String+Extension.swift
//  S-Forum
//
//  Created by Fakunabs on 06/11/2023.
//

import Foundation

extension String {
    var containsNumber: Bool {
        let regex = ".*[0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
}
