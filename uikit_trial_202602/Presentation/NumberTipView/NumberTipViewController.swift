//
//  NumberTipViewController.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Combine
import UIKit

class NumberTipViewController: UIViewController {

    // MARK: - Dependencies

    private let viewModel: NumberTipViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    init(viewModel: NumberTipViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private let tipLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tipLabel])
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
        setupNavigationBar()
        setupBindings()
        Task {
            await viewModel.fetchTip()
        }
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(didTapShare)
        )
        navigationItem.rightBarButtonItem = shareButton
    }

    private func setupBindings() {
        viewModel.tip
            .map { Optional($0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: tipLabel)
            .store(in: &cancellables)
    }

    // MARK: - Actions

    @objc private func didTapShare() {
        let text = viewModel.tip.value
        guard !text.isEmpty else { return }
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
