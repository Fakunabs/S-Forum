//
//  AppFonts.swift
//  S-Forum
//
//  Created by Fakunabs on 29/10/2023.
//

import UIKit

struct AppFonts {
    static let fontGilroyMedium = "Gilroy-Medium"
    static let fontSourceSans3Light = "SourceSans3-Light"
    static let fontSourceSans3SemiBold = "SourceSans3-SemiBold"
    
    static func fontGilroyMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: fontGilroyMedium, size: size)
    }
    
    static func fontSourceSans3Light(size: CGFloat) -> UIFont? {
        return UIFont(name: fontSourceSans3Light, size: size)
    }
    
    static func fontSourceSans3SemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: fontSourceSans3SemiBold, size: size)
    }
}
