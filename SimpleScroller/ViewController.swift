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

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var continerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    var viewProvider: ViewProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        prepareContentView()
    }

    private func prepareContentView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(continerView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            // continerView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
}


extension ViewController: ViewConsumer {
     func loadContainerView(containingView: UIView) {
       continerView.addSubview(containingView)
       containingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containingView.topAnchor.constraint(equalTo: continerView.topAnchor),
            containingView.leadingAnchor.constraint(equalTo: continerView.leadingAnchor),
            containingView.trailingAnchor.constraint(equalTo: continerView.trailingAnchor),
            containingView.bottomAnchor.constraint(equalTo: continerView.bottomAnchor),
        ])
    }
}
