//
//  NumberTipViewModel.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Combine
import Dependencies
import Foundation

final class PokedexViewModel {

    // MARK: - State

    struct State: Equatable {
        var number: Int
        var data: PokedexData?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    // MARK: - Dependency

    @Dependency(\.pokemonApiRepository) private var repository

    // MARK: - Output

    let state: CurrentValueSubject<State, Never>

    // MARK: - Init

    init(number: Int) {
        self.state = .init(State(number: number))
    }

    // MARK: - Methods

    func fetchTip() async {
        updateState { state in
            state.isLoading = true
            state.errorMessage = nil
        }

        do {
            let data = try await repository.getPokedexData(state.value.number)
            updateState { state in
                state.data = data
                state.isLoading = false
            }
        } catch let error {
            updateState { state in
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
            print(error.localizedDescription)
        }
    }

    // MARK: - Private Methods

    private func updateState(_ update: (inout State) -> Void) {
        var newState = state.value
        update(&newState)
        state.send(newState)
    }

}
