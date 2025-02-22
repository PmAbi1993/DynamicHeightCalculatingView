//
//  TextInputCollectionCell.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

// Summary of changes (23/2/25):
// - Added keyboard handling functionality
// - Implemented UITextFieldDelegate methods
// - Added first responder management
// - Configured return key to dismiss keyboard

import UIKit

class TextInputCollectionCell: UICollectionViewCell, UITextFieldDelegate {
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }

    private func setupTextField() {
        textField.delegate = self
        textField.returnKeyType = .done
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Handle text changes if needed
        return true
    }
}
