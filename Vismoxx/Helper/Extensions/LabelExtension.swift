//
//  LabelExtension.swift
//  Vismoxx
//
//  Created by Duron Cox on 11/8/20.
//  Copyright © 2020 Duron Cox. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func set_defualt_font(with text: String, size: CGFloat) {
        
        let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(rgb: 0x2C393F),
            .font: UIFont(name: "Noto Sans Oriya", size: size) ?? UIFont()]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }

    func set_defualt_bold_font(with text: String, size: CGFloat) {
        
        let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(rgb: 0x2C393F),
            .font: UIFont(name: "Noto Sans Oriya Bold", size: size) ?? UIFont()]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
    
}
