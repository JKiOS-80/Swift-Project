//
//  HomeRoutes.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit

enum SelectedRoute: Int {
    case HOME = 1
    case PRODUCT = 2
    case WORKPLAN = 3
    case QUOTE = 4
    case CREATENEW = 5
    case IMPORT = 6
}

extension HomeViewController {
    
    internal func goto_new_route(with route: SelectedRoute) {
        switch route {
        case SelectedRoute.HOME:
            config_home_state()
        case SelectedRoute.PRODUCT:
            config_products_state()
        case SelectedRoute.WORKPLAN:
            config_plan_state()
        case SelectedRoute.QUOTE:
            config_quote_state()
        case SelectedRoute.CREATENEW:
            segue_create_new()
        case SelectedRoute.IMPORT:
            config_import_state()
        }
    }
    
    private func config_home_state() {
        selectedRoute = SelectedRoute.HOME
        update_nav_backgrounds(with: nav_home_outter_view)
        toggle_product_selector(hide: true)
    }
    
    private func config_products_state() {
        selectedRoute = SelectedRoute.PRODUCT
        update_nav_backgrounds(with: nav_products_outter_view)
        toggle_product_selector(hide: false)
    }
    
    private func config_plan_state() {
        add_nav_segue_animation(with: HomeViewController.workplan_segue, nav_plan_outter_view)
    }
    
    private func config_quote_state() {
        add_nav_segue_animation(with: HomeViewController.quote_segue, nav_quote_outter_view)
    }
    
    private func segue_create_new() {
        add_nav_segue_animation(with: HomeViewController.scene_segue, nav_create_outter_view)
    }
    
    private func config_import_state() {
//        MARK: ADD CODE HERE FOR IMPORT
//        update_nav_backgrounds(with: nav_import_outter_view)
    }
    
    private func add_nav_segue_animation(with segue: String, _ selectedView: UIView) {
        self.clear_nav_items_backgrounds()
        
        UIView.animate(withDuration: 0.2) {
            self.add_gray_background(view: selectedView)
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        } completion: { (_) in
            self.performSegue(withIdentifier: segue, sender: self)
        }
    }
    
    private func update_nav_backgrounds(with selectedView: UIView) {
        self.clear_nav_items_backgrounds()
        UIView.animate(withDuration: 0.2, animations: {
            self.add_gray_background(view: selectedView)
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        })
    }
    
    private func clear_nav_items_backgrounds() {
        nav_home_outter_view.backgroundColor = UIColor.clear
        nav_products_outter_view.backgroundColor = UIColor.clear
        nav_create_outter_view.backgroundColor = UIColor.clear
        nav_import_outter_view.backgroundColor = UIColor.clear
        nav_plan_outter_view.backgroundColor = UIColor.clear
        nav_quote_outter_view.backgroundColor = UIColor.clear
    }
    
    private func add_gray_background(view: UIView) {
        view.backgroundColor = UIColor(rgb: 0xCDCDCD)
    }
    
    private func toggle_product_selector(hide hideView: Bool) {

        selector_view_top_constraint.constant = hideView ? 0 : 15
        product_selector_view.alpha = hideView ? 0 : 1
        UIView.animate(withDuration: 0.2, animations: {
            self.collectionView.reloadData()
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        })
    }
}
