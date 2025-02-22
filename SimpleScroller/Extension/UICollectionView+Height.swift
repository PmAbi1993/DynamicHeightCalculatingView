//
//  UICollectionView+Height.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

extension UICollectionView {
    /**
     Calculates the dynamic height of a UICollectionView based on its content.
     
     This function computes the total height required to display all items in the collection view,
     taking into account the layout properties and content insets. It is particularly useful when
     you need to dynamically adjust the height of a collection view based on its content size.
     
     The function performs the following steps:
     1. Validates the collection view's layout and data source.
     2. Calculates the available width for content by subtracting the content insets from the bounds width.
     3. Iterates through each section to calculate:
        - Header height (if any)
        - Footer height (if any)
        - Height of all rows in the section based on item size, spacing, and number of items
     4. Sums up the heights of all sections to determine the total height.
     
     Note: If the collection view's delegate implements `collectionView(_:layout:sizeForItemAt:)`,
     the function will use dynamic cell heights. Otherwise, it assumes uniform cell heights
     defined by `layout.itemSize`.
     
     - Returns: The total height required to display all content in the collection view.
               Returns 0 if the layout is not a UICollectionViewFlowLayout or if the data source is nil.
     */
    func dynamicHeightOfCollectionView() -> CGFloat {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout,
              let dataSource = dataSource else { return 0 }
        
        // Calculate the available width for content
        let contentWidth = bounds.width - (contentInset.left + contentInset.right)
        
        // Get the total number of sections in the collection view
        let numberOfSections = dataSource.numberOfSections?(in: self) ?? 1
        
        var totalHeight: CGFloat = 0
        
        for section in 0..<numberOfSections {
            // Calculate header height for the section
            let headerHeight = (layout.headerReferenceSize.height > 0) ? layout.headerReferenceSize.height : 0
            
            // Calculate footer height for the section
            let footerHeight = (layout.footerReferenceSize.height > 0) ? layout.footerReferenceSize.height : 0
            
            // Add header height to total height
            totalHeight += headerHeight
            
            // Get the number of items in the current section
            let numberOfItems = dataSource.collectionView(self, numberOfItemsInSection: section)
            
            // Calculate the number of items that can fit in a single row
            let itemsPerRow = max(1, Int((contentWidth + layout.minimumInteritemSpacing) / (layout.itemSize.width + layout.minimumInteritemSpacing)))
            
            // Calculate the number of rows needed to display all items in the section
            let rows = Int(ceil(Double(numberOfItems) / Double(itemsPerRow)))
            
            if let delegate = delegate as? UICollectionViewDelegateFlowLayout {
                // Use dynamic cell heights if the delegate is available
                for row in 0..<rows {
                    for item in 0..<itemsPerRow {
                        let indexPath = IndexPath(item: item, section: section)
                        let itemSize = delegate.collectionView?(self, layout: layout, sizeForItemAt: indexPath) ?? layout.itemSize
                        totalHeight += itemSize.height + (row < rows - 1 ? layout.minimumLineSpacing : 0)
                    }
                }
            } else {
                // Use uniform cell heights if the delegate is not available
                totalHeight += CGFloat(rows) * (layout.itemSize.height + layout.minimumLineSpacing) - layout.minimumLineSpacing
            }
            
            // Add footer height to total height
            totalHeight += footerHeight
        }
        
        return totalHeight
    } 
}
