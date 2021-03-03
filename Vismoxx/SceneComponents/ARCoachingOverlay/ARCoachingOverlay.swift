//
//  ARCoachingOverlay.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/3/21.
//
import ARKit

extension EditSceneController: ARCoachingOverlayViewDelegate{
    
  //1. Called When The ARCoachingOverlayView Is Active And Displayed
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        modal_ready_ar_placement = false
        print("The start")
    }
  
  //2. Called When The ARCoachingOverlayView Is No Active And No Longer Displayer
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        self.show_back_to_scene_btn()
        self.modal_ready_ar_placement = true
        print("The end")
    }
  
  //3. Called When Tracking Conditions Are Poor Or The Seesion Needs Restarting
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        self.modal_ready_ar_placement = false
        print("The reset")
    }
    
    internal func addCoaching() {
        config_overlay()
        DispatchQueue.main.async {
            self.view.addSubview(self.coachingOverlay!)
            self.loadViewIfNeeded()
        }
    }
    
    private func config_overlay() {
        coachingOverlay = ARCoachingOverlayView()
        coachingOverlay?.delegate = self
        #if !targetEnvironment(simulator)
        coachingOverlay?.session = arRealityView?.session
        #endif
        coachingOverlay?.frame = self.view.frame
        coachingOverlay?.activatesAutomatically = true
        coachingOverlay?.setActive(false, animated: true)
        coachingOverlay?.goal = .horizontalPlane
    }

}
