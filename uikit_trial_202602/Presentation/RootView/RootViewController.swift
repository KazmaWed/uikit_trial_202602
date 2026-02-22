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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private let incrementButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "plus")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20)
        config.cornerStyle = .capsule
        return UIButton(configuration: config)
    }()

    private let resetButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.counterclockwise")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20)
        config.cornerStyle = .capsule
        return UIButton(configuration: config)
    }()
    
    private let decrementButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "minus")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20)
        config.cornerStyle = .capsule
        return UIButton(configuration: config)
    }()

    private let searchButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "ポケモンを調べる"
        config.cornerStyle = .large
        return UIButton(configuration: config)
    }()
    
    private lazy var stackView: UIStackView = {
        let buttonsStack = UIStackView(arrangedSubviews: [decrementButton, resetButton, incrementButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 16
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        let vStack = UIStackView(arrangedSubviews: [valueLabel, buttonsStack, searchButton])
        vStack.axis = .vertical
        vStack.spacing = 24
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
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
        viewModel.state
            .map { String(format: "No. %03d", $0.value) }
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

        searchButton.addAction(UIAction { [weak self] _ in
            self?.navigateToNumberTip()
        }, for: .touchUpInside)
    }

    private func navigateToNumberTip() {
        let number = viewModel.state.value.value
        let viewModel = PokedexViewModelBuilder().build(with: number)
        let vc = PokedexViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

