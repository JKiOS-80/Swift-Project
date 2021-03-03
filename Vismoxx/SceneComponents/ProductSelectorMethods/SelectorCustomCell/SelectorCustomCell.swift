//
//  SelectorCustomCell.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/5/21.
//

import Foundation
import UIKit

class SelectorCustomCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnail_img: UIImageView!
    
    @IBOutlet weak var title_lbl: UILabel!
    
    @IBOutlet weak var selected_icon: UIView!
    
    var model: ARModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initalSetup()
        title_lbl.text = "Product Name"
    }
    
    public func configure(with model: ARModel) {
        print("The model \(model)")
        self.model = model
        title_lbl.text = model.modalContent.displayName ?? ""
        thumbnail_img.image = model.thumbnail_img
    }
    
    private func initalSetup() {
        addCheckStyles()
    }
    private func addCheckStyles() {
        selected_icon.clipsToBounds = true
        selected_icon.layer.cornerRadius = 15
        selected_icon.isHidden = true
    }
    
    
}
