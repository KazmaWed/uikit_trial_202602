//
//  RootViewModel.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/17.
//

import Combine
import Dependencies

final class RootViewModel {

    // MARK: - State

    struct State: Equatable {
        var value: Int = 1
    }

    // MARK: - Dependencies

    @Dependency(\.counterRepository) private var counterRepository

    // MARK: - Output

    let state: CurrentValueSubject<State, Never>

    // MARK: - Init

    init() {
        self.state = .init(State())
        let initialValue = counterRepository.getValue()
        self.state.send(State(value: initialValue))
    }

    // MARK: - Methods

    func increment() {
        counterRepository.increment()
        updateState { state in
            state.value = counterRepository.getValue()
        }
    }

    func decrement() {
        counterRepository.decrement()
        updateState { state in
            state.value = counterRepository.getValue()
        }
    }

    func reset() {
        counterRepository.reset()
        updateState { state in
            state.value = counterRepository.getValue()
        }
    }

    // MARK: - Private Methods

    private func updateState(_ update: (inout State) -> Void) {
        var newState = state.value
        update(&newState)
        state.send(newState)
    }
}
