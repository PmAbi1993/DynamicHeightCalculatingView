//
//  StackedImagesViewBuilder.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

class StackedImagesViewBuilder: ViewProvider {
    // Reuqirements:
    // instead of passing [UIImageView], Add everyting to a stack view and return the stackview
    internal weak var viewConsumer: ViewConsumer?
    init(viewConsumer: ViewConsumer) {
        self.viewConsumer = viewConsumer
    }
    func contentView() -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        getSFSymbolsImageStrings().forEach {
            let imageView: UIImageView = UIImageView(image: createSFSymbolImage(named: $0))
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }

    // Requirements:
    // Create a function that accepts a string and returns a UIImage
    // The function should create an SFSymbol image using the input string
    // If the SFSymbol doesn't exist, return a default UIImage
    func createSFSymbolImage(named symbolName: String) -> UIImage {
        if let image = UIImage(systemName: symbolName) {
            return image
        } else {
            return UIImage(systemName: "questionmark.circle") ?? UIImage()
        }
    }


    func getSFSymbolsImageStrings() -> [String] {
        return [
            "circle", "square", "triangle", "star", "heart",
            "cloud", "moon", "sun", "bolt", "flag",
            "bell", "envelope", "gear", "person", "house",
            "car", "airplane", "book", "camera", "pencil"
        ]
    }
    
    func build() {
        self.viewConsumer?.loadContainerView(containingView: contentView())
    }
    
}
