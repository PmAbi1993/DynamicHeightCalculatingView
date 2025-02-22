//
//  CollectionsViewBuilder.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

class CollectionsViewBuilder: UIView, ViewProvider {
    internal weak var viewConsumer: ViewConsumer?
    
    init(viewConsumer: ViewConsumer? = nil) {
        self.viewConsumer = viewConsumer
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contentView() -> UIView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        return collectionView
    }
    
    func calculateHeight() -> CGFloat {
        let numberOfItems = 30 // Replace with your actual data source count
        let itemsPerRow = floor((UIScreen.main.bounds.width - 20) / 100) // Adjust based on your layout
        let rows = ceil(CGFloat(numberOfItems) / itemsPerRow)
        let height = rows * 100 + (rows - 1) * 10 // Adjust based on your layout
        return height
    }
}

extension CollectionsViewBuilder: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = "Cell \(indexPath.row)"
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        return cell
    }
}
