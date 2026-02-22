//
//  NumberTipViewController.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Combine
import UIKit

class PokedexViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let imageSize: CGFloat = 180
    }

    // MARK: - Dependencies

    private let viewModel: PokedexViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    init(viewModel: PokedexViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private let spriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var stackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [numberLabel, nameLabel, spriteImageView])
        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.alignment = .leading
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
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
        view.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spriteImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            spriteImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),

            activityIndicator.centerXAnchor.constraint(equalTo: spriteImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: spriteImageView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            activityIndicator.heightAnchor.constraint(equalToConstant: Constants.imageSize),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                // Always show number (available from init)
                self?.numberLabel.text = "No. \(String(format: "%03d", state.number))"

                // Handle loading state
                if state.isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.nameLabel.text = "Loading..."
                    self?.spriteImageView.image = nil
                    return
                }

                self?.activityIndicator.stopAnimating()

                guard let data = state.data else {
                    self?.nameLabel.text = ""
                    return
                }

                // Update name label
                self?.nameLabel.text = data.name.capitalized

                // Load image after text rendering is complete
                if let urlString = data.sprites.frontDefault,
                   let url = URL(string: urlString) {
                    DispatchQueue.main.async {
                        self?.loadImage(from: url)
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func loadImage(from url: URL) {
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.spriteImageView.image = UIImage(data: data)
            }
        }
    }

    // MARK: - Actions

    @objc private func didTapShare() {
        guard let data = viewModel.state.value.data else { return }
        let text = "No. \(String(format: "%03d", data.id))  \(data.name.capitalized)"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
