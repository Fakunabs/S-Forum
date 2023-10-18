//
//  NSObject+Extension.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
