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

    // MARK: - Dependency

    @Dependency(\.pokemonApiRepository) private var repository

    // MARK: - Properties

    private let number: Int

    // MARK: - Output

    let data: CurrentValueSubject<PokedexData?, Never> = .init(nil)

    // MARK: - Init

    init(number: Int) {
        self.number = number
    }

    // MARK: - Methods

    func fetchTip() async {
        do {
            let data = try await repository.getPokedexData(number)
            self.data.send(data)
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
