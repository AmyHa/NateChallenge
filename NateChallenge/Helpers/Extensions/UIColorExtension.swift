//
//  UIColorExtension.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit

extension UIColor {
    class func colorFromHexString(_ hexString: String, alpha: Float = 1.0) -> UIColor {
        var rgbValue: CUnsignedInt = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0xFF) / 255.0,
                alpha: CGFloat(alpha))
    }
}
