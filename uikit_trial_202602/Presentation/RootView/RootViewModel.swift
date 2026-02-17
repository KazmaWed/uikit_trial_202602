//
//  RootViewModel.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/17.
//

import Combine
import Dependencies

final class RootViewModel {

    // MARK: - Dependencies

    @Dependency(\.counterRepository) private var counterRepository

    // MARK: - Output

    let value: CurrentValueSubject<Int, Never> = .init(0)

    // MARK: - Methods

    func increment() {
        counterRepository.increment()
        value.send(counterRepository.getValue())
    }

    func decrement() {
        counterRepository.decrement()
        value.send(counterRepository.getValue())
    }

    func reset() {
        counterRepository.reset()
        value.send(counterRepository.getValue())
    }
}
