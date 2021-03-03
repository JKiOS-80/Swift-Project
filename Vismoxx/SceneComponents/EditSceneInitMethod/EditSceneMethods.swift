//
//  EditSceneMethods.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/1/21.
//

import UIKit
import RealityKit
import ARKit
import FocusEntity

extension EditSceneController: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        print("the didUpdate")
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("the didFailWithError")
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("the didAdd")
    }
    
    
    internal func inital_setup() {
        self.add_layout_styles()
        self.toggle_scene(camera: false)
        self.addCoaching()
    }
    
    internal func add_layout_styles() {
        self.add_minimenu_style()
        self.add_minimenu_open_style()
        self.add_ar_styles()
        self.add_control_move_style()
        self.add_control_rotate_style()
        self.add_control_scale_style()
        self.add_product_selector_view_style()
        self.loadViewIfNeeded()
    }
    
    internal func toggle_scene(camera: Bool) {
        let frame = self.view.frame
        arRealityView = nil
        arRealityView = FocusARView(frame: frame, camera: camera)
        if camera {
            arRealityView?.session.delegate = self
            #if !targetEnvironment(simulator)
            coachingOverlay?.session = arRealityView?.session
            #endif
        }
        
        self.scene_container_view.addSubview(arRealityView!)
    }
        
    internal func addSelectedModal() {
        if let selected = selectedModal {
            let anchor = AnchorEntity(world: [0,0,-4])
            if let entity = selected.modelEntity?.clone(recursive: true) {
                // MARK: Edit entity.scale based on entity
                entity.scale = SIMD3<Float>(0.016, 0.016, 0.016)
                entity.generateCollisionShapes(recursive: true)
                anchor.addChild(entity)
                arRealityView?.installGestures(.rotation, for: entity)
            }
            arRealityView?.scene.addAnchor(anchor)
            show_scene_ar_btn()
        }
    }
    
    internal func destory_scene() {
        self.arRealityView?.session.pause()
        self.arRealityView?.removeFromSuperview()
        self.arRealityView = nil
    }
    
    private func add_minimenu_style() {
        view_mini_menu.layer.cornerRadius = 50
        view_mini_menu.addShadow()
    }
    
    private func add_minimenu_open_style() {
        edit_btn_container_view.layer.cornerRadius = 30
        edit_btn_container_view.addShadow()
    }
    
    private func add_ar_styles() {
        ar_btn_container_view.layer.cornerRadius = 30
        ar_btn_container_view.addShadow()
    }
    
    private func add_control_move_style() {
        control_move_container.layer.cornerRadius = 30
        control_move_container.addShadow()
    }
    
    private func add_control_rotate_style() {
        control_rotate_container.layer.cornerRadius = 30
        control_rotate_container.addShadow()
    }
    
    private func add_control_scale_style() {
        control_scale_container.layer.cornerRadius = 30
        control_scale_container.addShadow()
    }
    
    private func add_product_selector_view_style() {
        product_selector_view.layer.cornerRadius = 10
        product_selector_view.addShadow()
    }
    
}
