//
//  HomeHeaderCell.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit

class HomeHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var content_view: UIView!
    @IBOutlet weak var img_container_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img_container_view.layer.cornerRadius = 10
        content_view.layer.cornerRadius = 10
        content_view.layer.shadowColor = UIColor.black.cgColor
        content_view.layer.shadowOpacity = 0.1
        content_view.layer.shadowOffset = .zero
        content_view.layer.shadowRadius = 10
        content_view.layer.shouldRasterize = true
    }
}
