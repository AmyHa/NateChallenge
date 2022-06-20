//
//  UIFontExtension.swift
//  NateChallenge
//
//  Created by Amy Ha on 20/06/2022.
//

import UIKit

extension UIFont {
    
    static func outfitBold(size: CGFloat = 15) -> UIFont? {
        return UIFont(name: "Outfit-Bold", size: size)
    }
    
    static func outfitSemiBold(size: CGFloat = 15) -> UIFont? {
        return UIFont(name: "Outfit-SemiBold", size: size)
    }
    
    static func outfitRegular(size: CGFloat = 15) -> UIFont? {
        return UIFont(name: "Outfit-Regular", size: size)
    }
}
