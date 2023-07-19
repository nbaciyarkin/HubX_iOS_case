//
//  UtilityHelper.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
import UIKit



class UtilityHelper {
    static func setButtonUnderlineTitle(button: UIButton, title: String, font: UIFont, color: UIColor) {
            let attrs = [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
            let attributedString = NSMutableAttributedString(string: (title), attributes:attrs)
            button.setAttributedTitle(attributedString, for: .normal)
            button.setAttributedTitle(attributedString, for: .highlighted)
            button.setAttributedTitle(attributedString, for: .selected)
        }
    
    static func createRubikFont(size: CGFloat, weight: UIFont.Weight) -> UIFont? {
        let fontName = "Rubik-VariableFont-wght\(weight.rawValue)"
        return UIFont(name: fontName, size: size)
    }
    
    static func createRubikFont(size: CGFloat, weightValue: CGFloat) -> UIFont? {
        let fontName = "Rubik-VariableFont-wght\(weightValue)"
        return UIFont(name: fontName, size: size)
    }
}
