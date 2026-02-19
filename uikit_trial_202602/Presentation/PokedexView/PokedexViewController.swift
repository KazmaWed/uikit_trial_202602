//
//  NumberTipViewController.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Combine
import UIKit

class PokedexViewController: UIViewController {

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
    
    private lazy var labelStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [numberLabel, nameLabel])
        sv.axis = .vertical
        sv.spacing = 4
        sv.alignment = .leading
        return sv
    }()

    private lazy var stackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [labelStack, spriteImageView])
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.alignment = .center
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
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spriteImageView.widthAnchor.constraint(equalToConstant: 180),
            spriteImageView.heightAnchor.constraint(equalToConstant: 180),
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
        viewModel.data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let data else { return }
                self?.numberLabel.text = "No. \(String(format: "%03d", data.id))"
                self?.nameLabel.text = data.name.capitalized
                if let urlString = data.sprites.frontDefault,
                   let url = URL(string: urlString) {
                    self?.loadImage(from: url)
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
        guard let data = viewModel.data.value else { return }
        let text = "No. \(String(format: "%03d", data.id))  \(data.name.capitalized)"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
