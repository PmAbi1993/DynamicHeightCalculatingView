//
//  UICollectionView+Register.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: String(describing: cellType))
    }
}
