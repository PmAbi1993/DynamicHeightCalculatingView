//
//  ViewController.swift
//  SimpleScroller
//
//  Created by Abhijith Pm on 22/2/25.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var viewProvider: ViewProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupScrollView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let viewProvider = viewProvider,
        let collectionViewHeight = viewProvider.staticHeightOfContentView() {
            containerView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
        }
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

extension ViewController: ViewConsumer {
    func loadContainerView(containingView: UIView) {
        containerView.addSubview(containingView)
        containingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Update scrollView content size
        scrollView.contentSize = containingView.bounds.size
    }
}
