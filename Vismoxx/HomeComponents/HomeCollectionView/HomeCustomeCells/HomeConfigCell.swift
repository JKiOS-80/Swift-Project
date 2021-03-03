//
//  HomeConfigCell.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit
import SceneKit

class HomeConfigCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail_img: UIImageView!
    
    @IBOutlet weak var outterContainer: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var subtext: UILabel!
    
    let thumbnailGen = ARQLThumbnailGenerator()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outterContainer.layer.cornerRadius = 10
        outterContainer.clipsToBounds = false
        outterContainer.backgroundColor = .white
        outterContainer.layer.shadowColor = UIColor.black.cgColor
        outterContainer.layer.shadowOpacity = 0.1
        outterContainer.layer.shadowOffset = .zero
        outterContainer.layer.shadowRadius = 10
        outterContainer.layer.shouldRasterize = true
    }
    
    public func configure(with model: ARModel) {
        name.text = model.modalContent.displayName
        subtext.text = model.modalContent.subtext
        
        thumbnail_img.image = model.thumbnail_img
    }
    
}
