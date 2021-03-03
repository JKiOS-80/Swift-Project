//
//  SceneMethods.swift
//  Vismoxx
//
//  Created by Duron Cox on 1/3/21.
//

import Foundation
import UIKit

extension EditSceneController {
    
    internal func add_menu_action() {
        if is_ar_enabled {
//            add_2d_scene()
            DispatchQueue.main.async {
                let homeController = self.navigationController?.viewControllers.last(where: { (controller) -> Bool in
                    controller != self
                })
                let model = self.selectedModal
                let models = self.available_models
                self.navigationController?.popViewController(animated: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let home = homeController {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: EditSceneController.storyBoardId) as? EditSceneController{
                            vc.selectedModal = model
                            vc.available_models = models
                            home.navigationController?.pushViewController(vc, animated: false)
                            
                        }

                    }
                }
            }
            
        } else {
            isMiniMenuOpen ? action_close_miniMenu() : action_open_miniMenu()
        }
    }
    
    
    internal func action_open_miniMenu() {
        UIView.animate(withDuration: 1.0, animations: {
            self.mini_menu_height.constant = self.height_constraint
            self.btn_menu_measurements.alpha = 1
            self.btn_menu_products.alpha = 1
            self.btn_menu_delete.alpha = 1
            self.img_menu_measurements.alpha = 1
            self.img_menu_products.alpha = 1
            self.img_menu_delete.alpha = 1
            
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        })
        self.isMiniMenuOpen = !self.isMiniMenuOpen
    }
    
    internal func action_close_miniMenu() {
        self.btn_menu_measurements.alpha = 0
        self.btn_menu_products.alpha = 0
        self.btn_menu_delete.alpha = 0
        self.img_menu_measurements.alpha = 0
        self.img_menu_products.alpha = 0
        self.img_menu_delete.alpha = 0
        UIView.animate(withDuration: 1.0, animations: {
            self.mini_menu_height.constant = 0
            
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        })
        self.isMiniMenuOpen = !self.isMiniMenuOpen
    }
    
    internal func show_scene_ar_btn() {
        UIView.animate(withDuration: 1.0, animations: {
            DispatchQueue.main.async {
                self.img_rotation_icon.alpha = 1
                self.ar_btn_container_view.alpha = 1
                self.loadViewIfNeeded()
            }
        })
    }
    
    internal func hide_scene_ar_btn() {
        UIView.animate(withDuration: 1.0, animations: {
            DispatchQueue.main.async {
                self.img_rotation_icon.alpha = 0
                self.ar_btn_container_view.alpha = 0
                self.loadViewIfNeeded()
            }
        })
    }
    
    internal func toggle_button_config() {
        if is_ar_enabled {
            self.action_close_miniMenu()
            self.ar_btn_container_view.alpha = 0
            self.img_rotation_icon.alpha = 0
            self.edit_btn_container_view.alpha = 0
            UIView.animate(withDuration: 1.0, animations: {
                DispatchQueue.main.async {
                    self.loadViewIfNeeded()
                }
            })
        } else {
            self.action_close_miniMenu()
            self.edit_btn_img.image = UIImage(named: "Icon-Edit")
            self.ar_btn_container_view.alpha = 1
            self.img_rotation_icon.alpha = 1
            self.edit_btn_container_view.alpha = 1
            self.controls_container_view.alpha = 0
            UIView.animate(withDuration: 1.0, animations: {
                DispatchQueue.main.async {
                    self.loadViewIfNeeded()
                }
            })
        }
    }
    typealias AddSceneCallback = ()->()
    private func add_2d_scene(_ onCompleted: AddSceneCallback? = nil) {
        DispatchQueue.main.async {
            self.coachingOverlay?.activatesAutomatically = false
            self.coachingOverlay?.setActive(false, animated: false)
            self.destory_scene()
            self.toggle_scene(camera: false)
            self.is_ar_enabled = !self.is_ar_enabled
            self.toggle_button_config()
            onCompleted?()
            
        }
    }
}
