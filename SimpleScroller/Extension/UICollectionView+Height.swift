//
//  UICollectionView+Height.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

extension UICollectionView {
    
    // Requirement: 
    // Create a function that will return dynamic height of collection view.
    // Use the delegates to calculate the height of each items.
    // The items can include  the below items
    // 1.Header
    //  1.1 Section Header
    //  1.2 Cells at each section
    //  1.3 Section Footer
    // 2.Footer
    // Scroll to each item before calculating the height and return the height after everything.
    
    func dynamicHeightOfCollectionView() -> CGFloat {
//        guard let delegate = delegate, let dataSource = dataSource else { return 0 }
        guard let dataSource = dataSource else { return 0 }
        
        var totalHeight: CGFloat = 0
        
        // Header
        if let headerView = dataSource.collectionView?(self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) {
            totalHeight += headerView.frame.height
        }
        
        let numberOfSections = dataSource.numberOfSections?(in: self) ?? 1
        
        for section in 0..<numberOfSections {
            // Section Header
            if let sectionHeaderView = dataSource.collectionView?(self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: section)) {
                totalHeight += sectionHeaderView.frame.height
            }
            
            // Cells
            let numberOfItems = dataSource.collectionView(self, numberOfItemsInSection: section)
            for item in 0..<numberOfItems {
                let indexPath = IndexPath(item: item, section: section)
                if let attributes = layoutAttributesForItem(at: indexPath) {
                    totalHeight += attributes.frame.height
                }
                scrollToItem(at: indexPath, at: .top, animated: false)
            }
            
            // Section Footer
            if let sectionFooterView = dataSource.collectionView?(self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: section)) {
                totalHeight += sectionFooterView.frame.height
            }
        }
        
        // Footer
        if let footerView = dataSource.collectionView?(self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: numberOfSections - 1)) {
            totalHeight += footerView.frame.height
        }
        
        return totalHeight
    }
}

