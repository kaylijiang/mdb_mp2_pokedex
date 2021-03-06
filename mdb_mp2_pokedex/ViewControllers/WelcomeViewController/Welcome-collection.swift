//
//  WelcomeViewController-collectionviewsrc.swift
//  mdb_mp2_pokedex
//
//  Created by Ajay Raj Merchia on 9/12/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// Number of Filter Cells to create
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Pokemon.ALL_POKE_FILTERS.count
    }
    
    /// Size of each Filter Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let IMG_WIDTH:Double = 266
        let IMG_HEIGHT:Double = 339
        let FINAL_WIDTH:Double = 100
        
        return CGSize(width: FINAL_WIDTH, height: IMG_HEIGHT/IMG_WIDTH * FINAL_WIDTH)
    }
    
    
    /// Pattern for creating the used cells
    ///
    /// - Parameters:
    ///   - collectionView: collection to add this cell to
    ///   - indexPath: index of Cell
    /// - Returns: Cell Containing Filter information
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Clean reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCellView
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Initialize the cell
        cell.awakeFromNib()
        let current_filter = Pokemon.ALL_POKE_FILTERS[indexPath.row]
        
        // Set the cell buttons/states
        cell.filterImageButton.setImage(UIImage(named: "lite_pokefilter_"+current_filter.lowercased()), for: UIControlState.normal)
        cell.filterImageButton.setImage(UIImage(named: "pokefilter_"+current_filter.lowercased()), for: UIControlState.selected)
        cell.filterImageButton.tag = indexPath.row
        cell.filterImageButton.addTarget(self, action: #selector(set_filter_button_state), for: .touchUpInside)
        cell.name_of_filter = current_filter.lowercased()
        
        
        // Appply filter logic to button
        if ["attack", "defense", "hp"].contains(current_filter.lowercased()) {
            cell.filterImageButton.isValueFilter = true
            cell.contentView.addSubview(cell.points_selected)
        }
        
        for i in 0..<selected_filters.count {
            if selected_filters[i].generic_repr().lowercased() == Pokemon.ALL_POKE_FILTERS[indexPath.row].lowercased() {
                cell.filterImageButton.isSelected = true
                if cell.filterImageButton.isValueFilter {
                    cell.points_selected.text = "\(selected_filters[i].int_comparee!) - 200"
                }
            }
        }
        
        
        
        filter_buttons.append(cell.filterImageButton)
        filter_collection.append(cell)

        
        return cell
    }
    
    
    
    
}
