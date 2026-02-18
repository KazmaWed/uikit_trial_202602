//
//  NumberTipViewModel.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Combine
import Dependencies

final class NumberTipViewModel {

    // MARK: - Dependency

    @Dependency(\.numberTipRepository) private var repository

    // MARK: - Properties

    private let number: Int

    // MARK: - Output

    let tip: CurrentValueSubject<String, Never> = .init("")

    // MARK: - Init

    init(number: Int) {
        self.number = number
    }

    // MARK: - Methods

    func fetchTip() {
        let tip = repository.getNumberTip(number)
        self.tip.send(tip)
    }

}
