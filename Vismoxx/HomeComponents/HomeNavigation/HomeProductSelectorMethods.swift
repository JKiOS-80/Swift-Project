//
//  HomeProductSelectorMethods.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit

enum ProductSelectorOptions: Int {
    case SYSTEMS = 0
    case WALLS = 1
    case DOORS = 2
    case FINISHES = 3
    case OTHER = 4
}

extension HomeViewController {
        
    internal func load_new_products(with products: ProductSelectorOptions){
        add_products_animation(with: products)
    }
    
    private func add_products_animation(with products: ProductSelectorOptions) {
        self.selectedProducts = products
        self.reset_product_items()
        
        UIView.animate(withDuration: 0.5) {
            self.add_selected_products_state(with: self.selectedProducts)
            self.collectionView.reloadData()
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        }
    }
    
    private func add_selected_products_state(with product: ProductSelectorOptions) {
        switch product {
        case .SYSTEMS:
            systems_selected_state()
        case .DOORS:
            doors_selected_state()
        case .WALLS:
            walls_selected_state()
        case .FINISHES:
            finishes_selected_state()
        case .OTHER:
            other_selected_state()
        }
    }
    
    private func reset_product_items() {
        system_product_lbl.alpha = 0.3
        system_product_line_view.alpha = 0
        walls_product_lbl.alpha = 0.3
        walls_product_line_view.alpha = 0
        doors_product_lbl.alpha = 0.3
        doors_product_line_view.alpha = 0
        finishes_product_lbl.alpha = 0.3
        finishes_product_line_view.alpha = 0
        other_product_lbl.alpha = 0.3
        other_product_line_view.alpha = 0
    }
    
    private func systems_selected_state() {
        system_product_lbl.alpha = 1
        system_product_line_view.alpha = 1
    }
    
    private func walls_selected_state() {
        walls_product_lbl.alpha = 1
        walls_product_line_view.alpha = 1
    }
    
    private func doors_selected_state() {
        doors_product_lbl.alpha = 1
        doors_product_line_view.alpha = 1
    }
    
    private func finishes_selected_state() {
        finishes_product_lbl.alpha = 1
        finishes_product_line_view.alpha = 1
    }
    
    private func other_selected_state() {
        other_product_lbl.alpha = 1
        other_product_line_view.alpha = 1
    }
    
}
