//
//  InitialViewModel.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import Foundation
import UIKit

protocol ViewProvider: AnyObject {
    var viewConsumer: ViewConsumer? { get set }
    func contentView() -> UIView
    func build()
    func staticHeightOfContentView() -> CGFloat?
}
extension ViewProvider {
    func staticHeightOfContentView() -> CGFloat? {
        return nil
    }
    func build() {
        self.viewConsumer?.loadContainerView(containingView: self.contentView())
    }
}
protocol ViewConsumer: AnyObject {
    func loadContainerView(containingView: UIView)
}
class StackedLabelViewBuilder: ViewProvider {
    private let strings: [String]
    internal weak var viewConsumer: ViewConsumer?
    
    init(strings: [String], viewConsumer: ViewConsumer) {
        self.strings = strings
        self.viewConsumer = viewConsumer
    }   

    func build() {
        viewConsumer?.loadContainerView(containingView: contentView())
    }
    
    func contentView() -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        for string in strings {
            let label = UILabel()
            label.text = string
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        
        return stackView
    }
}
