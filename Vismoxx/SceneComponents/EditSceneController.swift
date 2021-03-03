//
//  EditSceneController.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit
import RealityKit
import ARKit
import FocusEntity

class EditSceneController: UIViewController, UIGestureRecognizerDelegate {
    static let storyBoardId = "EditSceneControllerId"
    
    @IBOutlet weak var view_mini_menu: UIView!
    
    @IBOutlet weak var scene_container_view: UIView!
    
    @IBOutlet weak var btn_miniMenuOpen: UIButton!
    
    @IBOutlet weak var edit_btn_container_view: UIView!
    
    @IBOutlet weak var edit_btn_img: UIImageView!
    
    @IBOutlet weak var ar_segue_btn: UIButton!
    
    @IBOutlet weak var ar_btn_container_view: UIView!
    
    @IBOutlet weak var img_menu_measurements: UIImageView!
    
    @IBOutlet weak var btn_menu_measurements: UIButton!
    
    @IBOutlet weak var img_menu_products: UIImageView!
    
    @IBOutlet weak var btn_menu_products: UIButton!
    
    @IBOutlet weak var img_menu_delete: UIImageView!
    
    @IBOutlet weak var btn_menu_delete: UIButton!
    
    @IBOutlet weak var img_rotation_icon: UIImageView!
    
    @IBOutlet weak var controls_container_view: UIView!
    
    @IBOutlet weak var control_move_container: UIView!
    
    @IBOutlet weak var control_move_img: UIImageView!
    
    @IBOutlet weak var control_rotate_container: UIView!
    
    @IBOutlet weak var control_rotate_img: UIImageView!
    
    @IBOutlet weak var control_scale_container: UIView!
    
    @IBOutlet weak var control_scale_img: UIImageView!
    
    @IBOutlet weak var product_selector_view: UIView!
    
    @IBOutlet weak var product_collectionview: UICollectionView!
    
    @IBOutlet weak var mini_menu_height: NSLayoutConstraint!
    
    internal let height_constraint: CGFloat = 340
    
    internal let largeProductCellID = "largeProductCellID"
    
    internal var isMiniMenuOpen: Bool = false
    
    internal var selectedModal: ARModel?
    
    internal var available_models: [ARModel]?
    
    internal var is_ar_enabled: Bool = false
    
    internal var arRealityView: FocusARView?
    
    internal var modal_ready_ar_placement = false
    
    internal var coachingOverlay: ARCoachingOverlayView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.inital_setup()
        self.addModel()
    }
    
    func addModel() {
        DispatchQueue.main.async {
            self.addSelectedModal()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arRealityView?.session.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.add_layout_styles()
    }
    
    @IBAction func mini_menu_action(_ sender: Any) {
        self.add_menu_action()
    }
    
    @IBAction func open_product_menu_action(_ sender: Any) {
        // TODO: Add code
    }
    
    @IBAction func update_measurements_action(_ sender: Any) {
        // TODO: Add code
    }
    
    @IBAction func delete_action(_ sender: Any) {
        // TODO: Add code
    }
    
    @IBAction func ar_button_action(_ sender: UIButton) {
        self.add_ar_scene()
    }
    
}
