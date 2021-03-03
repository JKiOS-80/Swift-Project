//
//  HomeCollectionDelegate.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit

enum HomeSections: Int {
    case TOUR = 0
    case RECENTS = 1
    case PRODUCTS = 2
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return get_row_count(perSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return get_cell(withIndex: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case HomeSections.RECENTS.rawValue:
//            let selectedRow = collectionView.cellForItem(at: indexPath) as! HomeConfigCell
            
            selectedModal = models[indexPath.row]

            // TODO: Add function to segue
            performSegue(withIdentifier: HomeViewController.scene_segue, sender: self)
        default:
            print("Error unknown selection")
        }
    }
    
    private func get_cell(withIndex indexPath: IndexPath) -> UICollectionViewCell {
        print("The sindexPath.section \(indexPath.section)")
    
        switch indexPath.section {
        case HomeSections.TOUR.rawValue:
            return setup_header_cell(with: indexPath)
        case HomeSections.RECENTS.rawValue:
            return setup_home_config_cell(with: indexPath)
        case HomeSections.PRODUCTS.rawValue:
            return setup_products_config_cell(with: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func setup_header_cell(with indexPath : IndexPath) -> HomeHeaderCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.home_header_id, for: indexPath) as! HomeHeaderCell
    }
    
    private func setup_home_config_cell(with indexPath : IndexPath) -> HomeConfigCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.homeCellID, for: indexPath) as! HomeConfigCell
        cell.configure(with: models[indexPath.row])

        return cell
    }
    
    private func setup_products_config_cell(with indexPath : IndexPath) -> HomeConfigCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.homeCellID, for: indexPath) as! HomeConfigCell
        cell.configure(with: sampleProducts[selectedProducts.rawValue][indexPath.row])
        return cell
    }
    
    private func get_row_count(perSection section: Int) -> Int {
        var count = 0
        switch section {
        case HomeSections.TOUR.rawValue:
            count = selectedRoute == SelectedRoute.HOME ? 1 : 0
        case HomeSections.RECENTS.rawValue:
            count = selectedRoute == SelectedRoute.HOME ? models.count : 0
        case HomeSections.PRODUCTS.rawValue:
            count = selectedRoute == SelectedRoute.PRODUCT ? sampleProducts[selectedProducts.rawValue].count : 0
        default:
            count = 0
        }
        
        return count
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat!
        var height: CGFloat!
        if indexPath.section == 0 {
            width =  self.collectionView.bounds.width
            height = 620
            return CGSize(width: width, height: height)
        } else  {
            width = (self.collectionView.bounds.width/3.0) - 20.0
            height = (width * 0.98)
            return CGSize(width: width, height: height)
        }

    }
}

