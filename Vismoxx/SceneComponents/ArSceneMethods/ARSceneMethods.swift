//
//  ARSceneMethods.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/3/21.
//

import Foundation
import UIKit
import ARKit
import RealityKit

extension EditSceneController {
    
    internal func add_ar_scene() {
        DispatchQueue.main.async {
            self.coachingOverlay?.activatesAutomatically = true
            self.coachingOverlay?.setActive(true, animated: true)
            self.destory_scene()
            self.toggle_scene(camera: true)
            self.registerGestureRecognizers()
            self.is_ar_enabled = !self.is_ar_enabled
            self.toggle_button_config()
        }
    }
    
    internal func show_back_to_scene_btn() {
        UIView.animate(withDuration: 1.0, animations: {
            DispatchQueue.main.async {
                self.edit_btn_container_view.alpha = 1
                self.edit_btn_img.image = UIImage(named: "Icon-Back")
                self.loadViewIfNeeded()
            }
        })
    }
    
    internal func hide_ar_controls() {
        UIView.animate(withDuration: 1.0, animations: {
            DispatchQueue.main.async {
                self.controls_container_view.alpha = 0
                self.loadViewIfNeeded()
            }
        })
    }
    
    internal func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        
        arRealityView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        if modal_ready_ar_placement {
            add_ar_selected_modal()
        }
    }
    
    private func add_ar_selected_modal() {
        guard let modal = selectedModal?.modelEntity  else {
            return
        }
        let modalAnchor = AnchorEntity(plane: .horizontal)
        modal.scale = SIMD3<Float>(0.01, 0.01, 0.01)
        modalAnchor.addChild(modal)
        arRealityView?.installGestures([.scale, .translation], for: modal)
        arRealityView?.scene.addAnchor(modalAnchor)
        show_ar_controls()
        modal_ready_ar_placement = false
        print("DEBUG: Modal Added")
    }
    
    private func show_ar_controls() {
        UIView.animate(withDuration: 1.0, animations: {
            DispatchQueue.main.async {
                self.controls_container_view.alpha = 1
                self.loadViewIfNeeded()
            }
        })
    }
}
