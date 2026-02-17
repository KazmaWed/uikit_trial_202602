//
//  ViewController.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/17.
//

import Combine
import UIKit

class RootViewController: UIViewController {

    // MARK: - Dependencies

    private let viewModel: RootViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    init(viewModel: RootViewModel = RootViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private let incrementButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "インクリメント"
        config.cornerStyle = .large
        return UIButton(configuration: config)
    }()

    private let decrementButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "デクリメント"
        config.cornerStyle = .large
        return UIButton(configuration: config)
    }()
    
    private let resetButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.title = "リセット"
        config.cornerStyle = .large
        return UIButton(configuration: config)
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [valueLabel, incrementButton, decrementButton, resetButton])
        sv.axis = .vertical
        sv.spacing = 16
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupActions()
        setupBindings()
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func setupBindings() {
        viewModel.value
            .map { String($0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: valueLabel)
            .store(in: &cancellables)
    }

    private func setupActions() {
        incrementButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.increment()
        }, for: .touchUpInside)

        decrementButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.decrement()
        }, for: .touchUpInside)

        resetButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.reset()
        }, for: .touchUpInside)
    }
}

