//
//  RootViewController.swift
//  CompactController
//
//  Created by Daria Cheremina on 13/11/2024.
//

import UIKit

class RootViewController: UIViewController {

    private let popoverView = PopoverViewController()

    private lazy var button: UIButton = {
        let button = UIButton()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Present"

        button.configuration = configuration

        button.addAction(UIAction { [weak self] _ in
            self?.presentPopover(button)
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width),
            button.heightAnchor.constraint(equalToConstant: button.intrinsicContentSize.height)
        ])
    }

    private func setupPopover(_ sender: UIButton) {
        popoverView.preferredContentSize = .init(width: 300, height: 280)
        popoverView.modalPresentationStyle = .popover
        popoverView.delegate = self

        let popoverPresentationController = popoverView.popoverPresentationController

        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = sender
        popoverPresentationController?.delegate = self
    }

    private func presentPopover(_ sender: UIButton) {
        button.isEnabled = false
        setupPopover(sender)

        self.present(popoverView, animated: true)
    }
}

extension RootViewController: UIPopoverPresentationControllerDelegate, PopoverViewControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        return .none
    }

    func smallerSizeOptionChosenOnSegment() {
        UIView.animate(withDuration: 0.8) {
            self.popoverView.preferredContentSize = .init(width: 300, height: 150)
            self.view.layoutIfNeeded()
        }
    }

    func biggerSizeOptionChosenOnSegment() {
        UIView.animate(withDuration: 0.8) {
            self.popoverView.preferredContentSize = .init(width: 300, height: 280)
            self.view.layoutIfNeeded()
        }
    }

    func closeButtonTapped() {
        self.dismiss(animated: true)
        button.isEnabled = true
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        false
    }
}
