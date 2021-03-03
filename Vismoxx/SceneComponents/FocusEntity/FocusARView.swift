//
//  FocusARView.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/3/21.
//

import UIKit
import ARKit
import RealityKit
import FocusEntity

class FocusARView: ARView {
 
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    convenience init(frame frameRect: CGRect, camera: Bool) {
        self.init(frame: frameRect)
        if camera {
            setup_world_config()
//            add_focusEntity()
        } else {
            setup_scene_config()
        }
    }

    private func setup_world_config() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func setup_scene_config() {
        self.cameraMode = .nonAR
        self.automaticallyConfigureSession = true
        self.environment.background = .color(.clear)
        self.add_light_anchor()
        self.add_camera_anchor()
    }
    
    private func add_focusEntity() {
        self.focusEntity = FocusEntity(on: self, focus: .classic)
        self.focusEntity?.delegate = self
        focusEntity?.isEnabled = false
    }
    
    private func add_light_anchor() {
        let pointLight = PointLight()
        pointLight.light.intensity = 10000
        let lightAnchor = AnchorEntity(world: [0,0,0])
        lightAnchor.addChild(pointLight)
        self.scene.addAnchor(lightAnchor)
    }
    
    private func add_camera_anchor() {
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0,1,1])
        cameraAnchor.addChild(camera)
        self.scene.addAnchor(cameraAnchor)
    }
    
      
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        focusEntity = nil
        focusEntity?.destroy()
    }
    
}

extension FocusARView: FocusEntityDelegate {
  func toTrackingState() {
    print("tracking")
  }
    
  func toInitializingState() {
    print("initializing")
  }
}
