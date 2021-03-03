//
//  HomeMethods.swift
//  Vismoxx
//
//  Created by Duron Cox on 12/31/20.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

extension HomeViewController {
    
    internal func setUpinit() {
        db = Database.database().reference()
        get_standrad_products()
    }
    
    internal func setup() {
        nav_home_outter_view.layer.cornerRadius = 4
        nav_products_outter_view.layer.cornerRadius = 4
        nav_create_outter_view.layer.cornerRadius = 4
        nav_import_outter_view.layer.cornerRadius = 4
        nav_plan_outter_view.layer.cornerRadius = 4
        nav_quote_outter_view.layer.cornerRadius = 4
        nav_create_icon_view.layer.cornerRadius = 10
    }
    
    internal func setupLayout() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = .vertical
        collectionView.collectionViewLayout = flow
    }
    
    internal func signIn() {
        if user_uuid == "" {
            Auth.auth().signInAnonymously() { (authResult, error) in
                guard let user = authResult?.user else { return }
                self.isAnonymous = user.isAnonymous  // true
                self.user_uuid = user.uid
            }
        }
    }
    
    private func getUserData(user_uuid : String) {
//        guard let user_doc_ref = db?.collection("user").document(user_uuid) else { return }
//
//        user_doc_ref.getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let data = document.data() else { return }
//
//                let userName = data["user_name"]
//
//                print("The user name is \(userName!)")
//
//            } else {
//                print("Document does not exist")
//            }
//        }
    }
    
    private func get_standrad_products() {
//        guard let recent_view_doc_ref = db?.collection("standard_products").document("products") else { return }
//
//        recent_view_doc_ref.getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let data = document.data() else { return }
//                
//                let systemData = self.convert_data_to_modals(data: data["systems"] as? [[String: Any]] ?? [])
//                let wallData = self.convert_data_to_modals(data: data["walls"] as? [[String: Any]] ?? [])
//                let doorData = self.convert_data_to_modals(data: data["doors"] as? [[String: Any]] ?? [])
//                let finishData = self.convert_data_to_modals(data: data["finishes"] as? [[String: Any]] ?? [])
//                let otherData = self.convert_data_to_modals(data: data["other"] as? [[String: Any]] ?? [])
//                self.sampleProducts = [systemData, wallData, doorData, finishData, otherData]
//
//            } else {
//                print("Two Document does not exist")
//            }
//        }
    }
    
    
    private func convert_data_to_modals(data: [[String: Any]]) -> [ARModel] {
        var modalData: [ARModel] = []

        for vData in data {
            let name = vData["name"] as! String
            let manufacturer = vData["manufacturer"] as! String
            
            let basic_modal = BasicModel(displayName: name, fileName: "", subtext: manufacturer)
            modalData.append(ARModel(model: basic_modal))
        }

        return modalData
    }
    
}

