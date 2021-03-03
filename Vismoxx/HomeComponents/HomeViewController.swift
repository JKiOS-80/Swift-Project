//
//  HomeViewController.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nav_home_outter_view: UIView!
    @IBOutlet weak var nav_products_outter_view: UIView!
    @IBOutlet weak var nav_plan_outter_view: UIView!
    @IBOutlet weak var nav_quote_outter_view: UIView!
    @IBOutlet weak var nav_create_outter_view: UIView!
    @IBOutlet weak var nav_import_outter_view: UIView!
    @IBOutlet weak var nav_create_icon_view: UIView!
    
    @IBOutlet weak var product_selector_view: UIView!

    @IBOutlet weak var system_product_lbl: UILabel!
    @IBOutlet weak var system_product_line_view: UIView!
    
    @IBOutlet weak var walls_product_lbl: UILabel!
    @IBOutlet weak var walls_product_line_view: UIView!
    
    @IBOutlet weak var doors_product_lbl: UILabel!
    @IBOutlet weak var doors_product_line_view: UIView!
    
    @IBOutlet weak var finishes_product_lbl: UILabel!
    @IBOutlet weak var finishes_product_line_view: UIView!
    
    @IBOutlet weak var other_product_lbl: UILabel!
    @IBOutlet weak var other_product_line_view: UIView!
    
    @IBOutlet weak var selector_view_top_constraint: NSLayoutConstraint!
    
    
    let sampleData: [BasicCellModel] = [BasicCellModel(image: nil, name: "Conference Room", subtext: "10/20/18, 2:03 PM"), BasicCellModel(image: nil, name: "Corner Office", subtext: "1/20/19, 5:03 PM"), BasicCellModel(image: nil, name: "Break Room", subtext: "2/10/19, 8:23 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM"), BasicCellModel(image: nil, name: "Office Room", subtext: "04/2/19, 9:20 AM")]

    
    internal var db: DatabaseReference?
    internal var user_uuid: String = ""
    internal var isAnonymous: Bool?
    internal var sampleProducts: [[ARModel]] = []
    
    internal var selectedModal: ARModel?
    
    internal var selectedRoute: SelectedRoute = SelectedRoute.HOME
    internal var selectedProducts: ProductSelectorOptions = ProductSelectorOptions.SYSTEMS
  
    static let scene_segue = "scene_segue"
    static let quote_segue = "quote_segue"
    static let workplan_segue = "workplan_segue"
    static let homeCellID = "homeCell"
    static let home_header_id = "home_header_id"
    
    
    internal var models: [ARModel] = {
        let file_manager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? file_manager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availbleModels: [ARModel] = []
        for fileName in files where fileName.hasSuffix("usdz") {
            let modalname = fileName.replacingOccurrences(of: ".usdz", with: "")
            let newModal = ARModel(model: BasicModel(displayName: "Wood Oak Door", fileName: fileName, subtext: "12/29/20, 5:00 PM"))
            availbleModels.append(newModal)
        }
        
        return availbleModels
    }()
    
    override func viewDidLoad() {
        self.setUpinit()
        self.setup()
        self.setupLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setup()
        self.setupLayout()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goto_new_route(with: selectedRoute)
        signIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedModal = nil
    }
    
    @IBAction func action_nav_item_pressed(_ sender: UIButton) {
        if sender.tag != selectedRoute.rawValue {
            let newRoute = is_modal_route(with: sender.tag) ? SelectedRoute.init(rawValue: sender.tag) ?? self.selectedRoute : self.selectedRoute
            goto_new_route(with: newRoute)
        }
    }
    
    @IBAction func action_product_item_pressed(_ sender: UIButton) {
        if sender.tag != selectedProducts.rawValue {
        load_new_products(with: ProductSelectorOptions.init(rawValue: sender.tag) ?? selectedProducts)
        
        }
    }
    
    private func is_modal_route(with tag: Int) -> Bool {
        return tag != SelectedRoute.QUOTE.rawValue || tag != SelectedRoute.IMPORT.rawValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? EditSceneController {
            print("The selectedModal \(selectedModal)")
            target.selectedModal = self.selectedModal
            target.available_models = models
        }
    }
}
