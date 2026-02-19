//
//  NumberTipRepositoryImpl.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Foundation

final class NumberTipRepositoryImpl: NumberTipRepository {
    func getNumberTip(_ number: Int) async -> String {
        guard
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(number)")
        else {
            return "Invalid URL"
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(
                PokemonResponse.self,
                from: data
            )
            return response.name
        } catch {
            return error.localizedDescription
        }
    }
}
