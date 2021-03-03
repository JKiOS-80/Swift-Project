//
//  ARModel.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit
import RealityKit
import Combine

class ARModel {
    
    var modalContent: BasicModel
    var thumbnail_img: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(model: BasicModel) {
        
        self.modalContent = model
        let image_name = model.fileName?.replacingOccurrences(of: ".usdz", with: "") ?? ""
        
        self.thumbnail_img = UIImage(named: image_name) ?? UIImage()
        
        guard let fileName = model.fileName else { return }
        
        if fileName != "" {
            self.cancellable = ModelEntity.loadModelAsync(named: fileName)
                .sink(receiveCompletion: { (loadCompletion) in
                    // Handle Error
                    print("DEBUG: Unable to load modelEntity for modelName: \(String(describing: self.modalContent.fileName))")
                }, receiveValue: { (modelEntity) in
                    self.modelEntity = modelEntity
                    self.modelEntity?.name = self.modalContent.fileName!
                    print("DEBUG: Successfully to load modelEntity for modelName: \(String(describing: self.modalContent.fileName))")
                })
        }
    }
}
