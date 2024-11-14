//
//  PopoverViewController.swift
//  CompactController
//
//  Created by Daria Cheremina on 13/11/2024.
//

import UIKit

protocol PopoverViewControllerDelegate {
    func smallerSizeOptionChosenOnSegment()
    func biggerSizeOptionChosenOnSegment()
    func closeButtonTapped()
}

class PopoverViewController: UIViewController {

    var delegate: PopoverViewControllerDelegate?

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["280pt", "150pt"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = .white
        control.backgroundColor = .systemGray5
        control.selectedSegmentIndex = 0

        return control
    }()

    private var closeButton: UIButton = {
        let imageConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemGray2, .systemGray5])

        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.image = UIImage(systemName: "xmark.circle.fill", withConfiguration: imageConfiguration)

        var button = UIButton()
        button.configuration = buttonConfig
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        addActions()
        setupView()
    }

    private func setupView() {
        view.addSubview(segmentedControl)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }

    private func addActions() {
        addActionForButton()
        addActionForSegmentedControl()
    }

    private func addActionForButton() {
        closeButton.addAction(UIAction { [weak self] _ in
            self?.closeButtonTapped()
        }, for: .touchUpInside)
    }

    private func addActionForSegmentedControl() {
        segmentedControl.addAction(
            UIAction { [weak self] _ in
                if self?.segmentedControl.selectedSegmentIndex == 0 {
                    self?.segmentBiggerSizeOptionChosen()
                } else {
                    self?.segmentSmallerSizeOptionChosen()
                }
            }, for: .valueChanged)
    }

    private func segmentSmallerSizeOptionChosen() {
        delegate?.smallerSizeOptionChosenOnSegment()
    }

    private func segmentBiggerSizeOptionChosen() {
        delegate?.biggerSizeOptionChosenOnSegment()
    }

    private func closeButtonTapped() {
        delegate?.closeButtonTapped()
    }
}
